import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/enrollment_model.dart';

class TrainingEnrollmentRepository {
  final SupabaseClient _client;

  TrainingEnrollmentRepository(this._client);

  Future<List<TrainingEnrollment>> getAll() async {
    final response = await _client
        .from('training.enrollments')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingEnrollment.fromJson(e)).toList();
  }

  Future<TrainingEnrollment> getById(String id) async {
    final response = await _client
        .from('training.enrollments')
        .select()
        .eq('id', id)
        .single();
    return TrainingEnrollment.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.enrollments').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.enrollments').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.enrollments').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingEnrollmentRepositoryProvider = Provider<TrainingEnrollmentRepository>((ref) {
  return TrainingEnrollmentRepository(Supabase.instance.client);
});

final trainingEnrollmentListProvider = FutureProvider<List<TrainingEnrollment>>((ref) async {
  return ref.watch(trainingEnrollmentRepositoryProvider).getAll();
});

final trainingEnrollmentDetailProvider = FutureProvider.family<TrainingEnrollment, String>((ref, id) async {
  return ref.watch(trainingEnrollmentRepositoryProvider).getById(id);
});
