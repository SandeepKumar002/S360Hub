import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/assessment_model.dart';

class TrainingAssessmentRepository {
  final SupabaseClient _client;

  TrainingAssessmentRepository(this._client);

  Future<List<TrainingAssessment>> getAll() async {
    final response = await _client
        .from('training.assessments')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingAssessment.fromJson(e)).toList();
  }

  Future<TrainingAssessment> getById(String id) async {
    final response = await _client
        .from('training.assessments')
        .select()
        .eq('id', id)
        .single();
    return TrainingAssessment.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.assessments').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.assessments').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.assessments').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingAssessmentRepositoryProvider = Provider<TrainingAssessmentRepository>((ref) {
  return TrainingAssessmentRepository(Supabase.instance.client);
});

final trainingAssessmentListProvider = FutureProvider<List<TrainingAssessment>>((ref) async {
  return ref.watch(trainingAssessmentRepositoryProvider).getAll();
});

final trainingAssessmentDetailProvider = FutureProvider.family<TrainingAssessment, String>((ref, id) async {
  return ref.watch(trainingAssessmentRepositoryProvider).getById(id);
});
