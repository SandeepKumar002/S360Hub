import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/survey_model.dart';

class SurveySurveyRepository {
  final SupabaseClient _client;

  SurveySurveyRepository(this._client);

  Future<List<SurveySurvey>> getAll() async {
    final response = await _client
        .from('survey.surveys')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => SurveySurvey.fromJson(e)).toList();
  }

  Future<SurveySurvey> getById(String id) async {
    final response = await _client
        .from('survey.surveys')
        .select()
        .eq('id', id)
        .single();
    return SurveySurvey.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('survey.surveys').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('survey.surveys').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('survey.surveys').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final surveySurveyRepositoryProvider = Provider<SurveySurveyRepository>((ref) {
  return SurveySurveyRepository(Supabase.instance.client);
});

final surveySurveyListProvider = FutureProvider<List<SurveySurvey>>((ref) async {
  return ref.watch(surveySurveyRepositoryProvider).getAll();
});

final surveySurveyDetailProvider = FutureProvider.family<SurveySurvey, String>((ref, id) async {
  return ref.watch(surveySurveyRepositoryProvider).getById(id);
});
