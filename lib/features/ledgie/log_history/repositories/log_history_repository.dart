import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/log_history_model.dart';

class LedgieLogHistoryRepository {
  final SupabaseClient _client;

  LedgieLogHistoryRepository(this._client);

  Future<List<LedgieLogHistory>> getAll() async {
    final response = await _client
        .from('ledgie.log_history')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieLogHistory.fromJson(e)).toList();
  }

  Future<LedgieLogHistory> getById(String id) async {
    final response = await _client
        .from('ledgie.log_history')
        .select()
        .eq('id', id)
        .single();
    return LedgieLogHistory.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.log_history').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.log_history').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.log_history').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieLogHistoryRepositoryProvider = Provider<LedgieLogHistoryRepository>((ref) {
  return LedgieLogHistoryRepository(Supabase.instance.client);
});

final ledgieLogHistoryListProvider = FutureProvider<List<LedgieLogHistory>>((ref) async {
  return ref.watch(ledgieLogHistoryRepositoryProvider).getAll();
});

final ledgieLogHistoryDetailProvider = FutureProvider.family<LedgieLogHistory, String>((ref, id) async {
  return ref.watch(ledgieLogHistoryRepositoryProvider).getById(id);
});
