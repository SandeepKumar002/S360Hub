import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/assessment_attempt_model.dart';

class TrainingAssessmentAttemptRepository {
  final SupabaseClient _client;

  TrainingAssessmentAttemptRepository(this._client);

  Future<List<TrainingAssessmentAttempt>> getAll() async {
    final response = await _client
        .from('training.assessment_attempts')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingAssessmentAttempt.fromJson(e)).toList();
  }

  Future<TrainingAssessmentAttempt> getById(String id) async {
    final response = await _client
        .from('training.assessment_attempts')
        .select()
        .eq('id', id)
        .single();
    return TrainingAssessmentAttempt.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.assessment_attempts').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.assessment_attempts').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.assessment_attempts').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingAssessmentAttemptRepositoryProvider = Provider<TrainingAssessmentAttemptRepository>((ref) {
  return TrainingAssessmentAttemptRepository(Supabase.instance.client);
});

final trainingAssessmentAttemptListProvider = FutureProvider<List<TrainingAssessmentAttempt>>((ref) async {
  return ref.watch(trainingAssessmentAttemptRepositoryProvider).getAll();
});

final trainingAssessmentAttemptDetailProvider = FutureProvider.family<TrainingAssessmentAttempt, String>((ref, id) async {
  return ref.watch(trainingAssessmentAttemptRepositoryProvider).getById(id);
});
