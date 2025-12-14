import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/survey_question_model.dart';

class SurveySurveyQuestionRepository {
  final SupabaseClient _client;

  SurveySurveyQuestionRepository(this._client);

  Future<List<SurveySurveyQuestion>> getAll() async {
    final response = await _client
        .from('survey.survey_questions')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => SurveySurveyQuestion.fromJson(e)).toList();
  }

  Future<SurveySurveyQuestion> getById(String id) async {
    final response = await _client
        .from('survey.survey_questions')
        .select()
        .eq('id', id)
        .single();
    return SurveySurveyQuestion.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('survey.survey_questions').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('survey.survey_questions').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('survey.survey_questions').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final surveySurveyQuestionRepositoryProvider = Provider<SurveySurveyQuestionRepository>((ref) {
  return SurveySurveyQuestionRepository(Supabase.instance.client);
});

final surveySurveyQuestionListProvider = FutureProvider<List<SurveySurveyQuestion>>((ref) async {
  return ref.watch(surveySurveyQuestionRepositoryProvider).getAll();
});

final surveySurveyQuestionDetailProvider = FutureProvider.family<SurveySurveyQuestion, String>((ref, id) async {
  return ref.watch(surveySurveyQuestionRepositoryProvider).getById(id);
});
