import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/survey_pulse_model.dart';

class SurveySurveyPulseRepository {
  final SupabaseClient _client;

  SurveySurveyPulseRepository(this._client);

  Future<List<SurveySurveyPulse>> getAll() async {
    final response = await _client
        .from('survey.survey_pulse')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => SurveySurveyPulse.fromJson(e)).toList();
  }

  Future<SurveySurveyPulse> getById(String id) async {
    final response = await _client
        .from('survey.survey_pulse')
        .select()
        .eq('id', id)
        .single();
    return SurveySurveyPulse.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('survey.survey_pulse').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('survey.survey_pulse').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('survey.survey_pulse').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final surveySurveyPulseRepositoryProvider = Provider<SurveySurveyPulseRepository>((ref) {
  return SurveySurveyPulseRepository(Supabase.instance.client);
});

final surveySurveyPulseListProvider = FutureProvider<List<SurveySurveyPulse>>((ref) async {
  return ref.watch(surveySurveyPulseRepositoryProvider).getAll();
});

final surveySurveyPulseDetailProvider = FutureProvider.family<SurveySurveyPulse, String>((ref, id) async {
  return ref.watch(surveySurveyPulseRepositoryProvider).getById(id);
});
