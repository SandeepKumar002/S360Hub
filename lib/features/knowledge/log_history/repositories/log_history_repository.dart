import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/log_history_model.dart';

class KnowledgeLogHistoryRepository {
  final SupabaseClient _client;

  KnowledgeLogHistoryRepository(this._client);

  Future<List<KnowledgeLogHistory>> getAll() async {
    final response = await _client
        .from('knowledge.log_history')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => KnowledgeLogHistory.fromJson(e)).toList();
  }

  Future<KnowledgeLogHistory> getById(String id) async {
    final response = await _client
        .from('knowledge.log_history')
        .select()
        .eq('id', id)
        .single();
    return KnowledgeLogHistory.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('knowledge.log_history').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('knowledge.log_history').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('knowledge.log_history').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final knowledgeLogHistoryRepositoryProvider = Provider<KnowledgeLogHistoryRepository>((ref) {
  return KnowledgeLogHistoryRepository(Supabase.instance.client);
});

final knowledgeLogHistoryListProvider = FutureProvider<List<KnowledgeLogHistory>>((ref) async {
  return ref.watch(knowledgeLogHistoryRepositoryProvider).getAll();
});

final knowledgeLogHistoryDetailProvider = FutureProvider.family<KnowledgeLogHistory, String>((ref, id) async {
  return ref.watch(knowledgeLogHistoryRepositoryProvider).getById(id);
});
