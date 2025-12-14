import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/log_history_model.dart';

class TaxforgeLogHistoryRepository {
  final SupabaseClient _client;

  TaxforgeLogHistoryRepository(this._client);

  Future<List<TaxforgeLogHistory>> getAll() async {
    final response = await _client
        .from('taxforge.log_history')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TaxforgeLogHistory.fromJson(e)).toList();
  }

  Future<TaxforgeLogHistory> getById(String id) async {
    final response = await _client
        .from('taxforge.log_history')
        .select()
        .eq('id', id)
        .single();
    return TaxforgeLogHistory.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('taxforge.log_history').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('taxforge.log_history').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('taxforge.log_history').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final taxforgeLogHistoryRepositoryProvider = Provider<TaxforgeLogHistoryRepository>((ref) {
  return TaxforgeLogHistoryRepository(Supabase.instance.client);
});

final taxforgeLogHistoryListProvider = FutureProvider<List<TaxforgeLogHistory>>((ref) async {
  return ref.watch(taxforgeLogHistoryRepositoryProvider).getAll();
});

final taxforgeLogHistoryDetailProvider = FutureProvider.family<TaxforgeLogHistory, String>((ref, id) async {
  return ref.watch(taxforgeLogHistoryRepositoryProvider).getById(id);
});
