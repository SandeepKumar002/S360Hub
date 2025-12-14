import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/log_history_model.dart';

class SurveyLogHistoryRepository {
  final SupabaseClient _client;

  SurveyLogHistoryRepository(this._client);

  Future<List<SurveyLogHistory>> getAll() async {
    final response = await _client
        .from('survey.log_history')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => SurveyLogHistory.fromJson(e)).toList();
  }

  Future<SurveyLogHistory> getById(String id) async {
    final response = await _client
        .from('survey.log_history')
        .select()
        .eq('id', id)
        .single();
    return SurveyLogHistory.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('survey.log_history').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('survey.log_history').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('survey.log_history').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final surveyLogHistoryRepositoryProvider = Provider<SurveyLogHistoryRepository>((ref) {
  return SurveyLogHistoryRepository(Supabase.instance.client);
});

final surveyLogHistoryListProvider = FutureProvider<List<SurveyLogHistory>>((ref) async {
  return ref.watch(surveyLogHistoryRepositoryProvider).getAll();
});

final surveyLogHistoryDetailProvider = FutureProvider.family<SurveyLogHistory, String>((ref, id) async {
  return ref.watch(surveyLogHistoryRepositoryProvider).getById(id);
});
