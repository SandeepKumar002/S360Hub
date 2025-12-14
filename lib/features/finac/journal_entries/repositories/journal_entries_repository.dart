import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/journal_entrie_model.dart';

class FinacJournalEntrieRepository {
  final SupabaseClient _client;

  FinacJournalEntrieRepository(this._client);

  Future<List<FinacJournalEntrie>> getAll() async {
    final response = await _client
        .from('finac.journal_entries')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacJournalEntrie.fromJson(e)).toList();
  }

  Future<FinacJournalEntrie> getById(String id) async {
    final response = await _client
        .from('finac.journal_entries')
        .select()
        .eq('id', id)
        .single();
    return FinacJournalEntrie.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.journal_entries').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.journal_entries').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.journal_entries').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacJournalEntrieRepositoryProvider = Provider<FinacJournalEntrieRepository>((ref) {
  return FinacJournalEntrieRepository(Supabase.instance.client);
});

final finacJournalEntrieListProvider = FutureProvider<List<FinacJournalEntrie>>((ref) async {
  return ref.watch(finacJournalEntrieRepositoryProvider).getAll();
});

final finacJournalEntrieDetailProvider = FutureProvider.family<FinacJournalEntrie, String>((ref, id) async {
  return ref.watch(finacJournalEntrieRepositoryProvider).getById(id);
});
