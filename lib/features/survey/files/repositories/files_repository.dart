import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/file_model.dart';

class SurveyFileRepository {
  final SupabaseClient _client;

  SurveyFileRepository(this._client);

  Future<List<SurveyFile>> getAll() async {
    final response = await _client
        .from('survey.files')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => SurveyFile.fromJson(e)).toList();
  }

  Future<SurveyFile> getById(String id) async {
    final response = await _client
        .from('survey.files')
        .select()
        .eq('id', id)
        .single();
    return SurveyFile.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('survey.files').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('survey.files').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('survey.files').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final surveyFileRepositoryProvider = Provider<SurveyFileRepository>((ref) {
  return SurveyFileRepository(Supabase.instance.client);
});

final surveyFileListProvider = FutureProvider<List<SurveyFile>>((ref) async {
  return ref.watch(surveyFileRepositoryProvider).getAll();
});

final surveyFileDetailProvider = FutureProvider.family<SurveyFile, String>((ref, id) async {
  return ref.watch(surveyFileRepositoryProvider).getById(id);
});
