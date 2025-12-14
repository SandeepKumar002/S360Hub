import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/log_history_model.dart';

class ShieldLogHistoryRepository {
  final SupabaseClient _client;

  ShieldLogHistoryRepository(this._client);

  Future<List<ShieldLogHistory>> getAll() async {
    final response = await _client
        .from('shield.log_history')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ShieldLogHistory.fromJson(e)).toList();
  }

  Future<ShieldLogHistory> getById(String id) async {
    final response = await _client
        .from('shield.log_history')
        .select()
        .eq('id', id)
        .single();
    return ShieldLogHistory.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('shield.log_history').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('shield.log_history').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('shield.log_history').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final shieldLogHistoryRepositoryProvider = Provider<ShieldLogHistoryRepository>((ref) {
  return ShieldLogHistoryRepository(Supabase.instance.client);
});

final shieldLogHistoryListProvider = FutureProvider<List<ShieldLogHistory>>((ref) async {
  return ref.watch(shieldLogHistoryRepositoryProvider).getAll();
});

final shieldLogHistoryDetailProvider = FutureProvider.family<ShieldLogHistory, String>((ref, id) async {
  return ref.watch(shieldLogHistoryRepositoryProvider).getById(id);
});
