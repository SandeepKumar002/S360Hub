import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/log_history_model.dart';

class FinacLogHistoryRepository {
  final SupabaseClient _client;

  FinacLogHistoryRepository(this._client);

  Future<List<FinacLogHistory>> getAll() async {
    final response = await _client
        .from('finac.log_history')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacLogHistory.fromJson(e)).toList();
  }

  Future<FinacLogHistory> getById(String id) async {
    final response = await _client
        .from('finac.log_history')
        .select()
        .eq('id', id)
        .single();
    return FinacLogHistory.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.log_history').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.log_history').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.log_history').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacLogHistoryRepositoryProvider = Provider<FinacLogHistoryRepository>((ref) {
  return FinacLogHistoryRepository(Supabase.instance.client);
});

final finacLogHistoryListProvider = FutureProvider<List<FinacLogHistory>>((ref) async {
  return ref.watch(finacLogHistoryRepositoryProvider).getAll();
});

final finacLogHistoryDetailProvider = FutureProvider.family<FinacLogHistory, String>((ref, id) async {
  return ref.watch(finacLogHistoryRepositoryProvider).getById(id);
});
