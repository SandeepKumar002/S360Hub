import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/log_history_model.dart';

class ContracforceLogHistoryRepository {
  final SupabaseClient _client;

  ContracforceLogHistoryRepository(this._client);

  Future<List<ContracforceLogHistory>> getAll() async {
    final response = await _client
        .from('contracforce.log_history')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ContracforceLogHistory.fromJson(e)).toList();
  }

  Future<ContracforceLogHistory> getById(String id) async {
    final response = await _client
        .from('contracforce.log_history')
        .select()
        .eq('id', id)
        .single();
    return ContracforceLogHistory.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('contracforce.log_history').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('contracforce.log_history').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('contracforce.log_history').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final contracforceLogHistoryRepositoryProvider = Provider<ContracforceLogHistoryRepository>((ref) {
  return ContracforceLogHistoryRepository(Supabase.instance.client);
});

final contracforceLogHistoryListProvider = FutureProvider<List<ContracforceLogHistory>>((ref) async {
  return ref.watch(contracforceLogHistoryRepositoryProvider).getAll();
});

final contracforceLogHistoryDetailProvider = FutureProvider.family<ContracforceLogHistory, String>((ref, id) async {
  return ref.watch(contracforceLogHistoryRepositoryProvider).getById(id);
});
