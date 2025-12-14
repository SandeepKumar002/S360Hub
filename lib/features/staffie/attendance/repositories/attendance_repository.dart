import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/attendance_model.dart';

class AttendanceRepository {
  final SupabaseClient _client;

  AttendanceRepository(this._client);

  Future<List<AttendanceLog>> getAttendanceLogs() async {
    final response = await _client
        .from('staffie.attendance_logs')
        .select()
        .order('attendance_date', ascending: false);
    return (response as List).map((e) => AttendanceLog.fromJson(e)).toList();
  }

  Future<void> checkIn(String employeeId, DateTime time) async {
    // Upsert logic typically, check if log exists for today
    final dateStr = time.toIso8601String().split('T')[0];
    
    // Check existing
    final existing = await _client.from('staffie.attendance_logs')
       .select()
       .eq('employee_id', employeeId)
       .eq('attendance_date', dateStr)
       .maybeSingle();

    if (existing == null) {
      await _client.from('staffie.attendance_logs').insert({
         'employee_id': employeeId,
         'attendance_date': dateStr,
         'check_in_time': time.toIso8601String(),
         'status': 'present', // Default
      });
    }
  }

  Future<void> checkOut(String logId, DateTime time) async {
    await _client.from('staffie.attendance_logs').update({
       'check_out_time': time.toIso8601String(),
    }).eq('id', logId);
  }
}

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepository(Supabase.instance.client);
});

final attendanceListProvider = FutureProvider<List<AttendanceLog>>((ref) async {
  return ref.watch(attendanceRepositoryProvider).getAttendanceLogs();
});
