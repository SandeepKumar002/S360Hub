import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/assessment_question_model.dart';

class TrainingAssessmentQuestionRepository {
  final SupabaseClient _client;

  TrainingAssessmentQuestionRepository(this._client);

  Future<List<TrainingAssessmentQuestion>> getAll() async {
    final response = await _client
        .from('training.assessment_questions')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingAssessmentQuestion.fromJson(e)).toList();
  }

  Future<TrainingAssessmentQuestion> getById(String id) async {
    final response = await _client
        .from('training.assessment_questions')
        .select()
        .eq('id', id)
        .single();
    return TrainingAssessmentQuestion.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.assessment_questions').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.assessment_questions').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.assessment_questions').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingAssessmentQuestionRepositoryProvider = Provider<TrainingAssessmentQuestionRepository>((ref) {
  return TrainingAssessmentQuestionRepository(Supabase.instance.client);
});

final trainingAssessmentQuestionListProvider = FutureProvider<List<TrainingAssessmentQuestion>>((ref) async {
  return ref.watch(trainingAssessmentQuestionRepositoryProvider).getAll();
});

final trainingAssessmentQuestionDetailProvider = FutureProvider.family<TrainingAssessmentQuestion, String>((ref, id) async {
  return ref.watch(trainingAssessmentQuestionRepositoryProvider).getById(id);
});
