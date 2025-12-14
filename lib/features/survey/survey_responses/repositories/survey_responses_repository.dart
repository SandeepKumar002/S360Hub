import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/survey_response_model.dart';

class SurveySurveyResponseRepository {
  final SupabaseClient _client;

  SurveySurveyResponseRepository(this._client);

  Future<List<SurveySurveyResponse>> getAll() async {
    final response = await _client
        .from('survey.survey_responses')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => SurveySurveyResponse.fromJson(e)).toList();
  }

  Future<SurveySurveyResponse> getById(String id) async {
    final response = await _client
        .from('survey.survey_responses')
        .select()
        .eq('id', id)
        .single();
    return SurveySurveyResponse.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('survey.survey_responses').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('survey.survey_responses').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('survey.survey_responses').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final surveySurveyResponseRepositoryProvider = Provider<SurveySurveyResponseRepository>((ref) {
  return SurveySurveyResponseRepository(Supabase.instance.client);
});

final surveySurveyResponseListProvider = FutureProvider<List<SurveySurveyResponse>>((ref) async {
  return ref.watch(surveySurveyResponseRepositoryProvider).getAll();
});

final surveySurveyResponseDetailProvider = FutureProvider.family<SurveySurveyResponse, String>((ref, id) async {
  return ref.watch(surveySurveyResponseRepositoryProvider).getById(id);
});
