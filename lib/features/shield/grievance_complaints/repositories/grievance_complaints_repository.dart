import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/grievance_complaint_model.dart';

class ShieldGrievanceComplaintRepository {
  final SupabaseClient _client;

  ShieldGrievanceComplaintRepository(this._client);

  Future<List<ShieldGrievanceComplaint>> getAll() async {
    final response = await _client
        .from('shield.grievance_complaints')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ShieldGrievanceComplaint.fromJson(e)).toList();
  }

  Future<ShieldGrievanceComplaint> getById(String id) async {
    final response = await _client
        .from('shield.grievance_complaints')
        .select()
        .eq('id', id)
        .single();
    return ShieldGrievanceComplaint.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('shield.grievance_complaints').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('shield.grievance_complaints').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('shield.grievance_complaints').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final shieldGrievanceComplaintRepositoryProvider = Provider<ShieldGrievanceComplaintRepository>((ref) {
  return ShieldGrievanceComplaintRepository(Supabase.instance.client);
});

final shieldGrievanceComplaintListProvider = FutureProvider<List<ShieldGrievanceComplaint>>((ref) async {
  return ref.watch(shieldGrievanceComplaintRepositoryProvider).getAll();
});

final shieldGrievanceComplaintDetailProvider = FutureProvider.family<ShieldGrievanceComplaint, String>((ref, id) async {
  return ref.watch(shieldGrievanceComplaintRepositoryProvider).getById(id);
});
