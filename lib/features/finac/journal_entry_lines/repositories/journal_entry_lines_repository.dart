import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/journal_entry_line_model.dart';

class FinacJournalEntryLineRepository {
  final SupabaseClient _client;

  FinacJournalEntryLineRepository(this._client);

  Future<List<FinacJournalEntryLine>> getAll() async {
    final response = await _client
        .from('finac.journal_entry_lines')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacJournalEntryLine.fromJson(e)).toList();
  }

  Future<FinacJournalEntryLine> getById(String id) async {
    final response = await _client
        .from('finac.journal_entry_lines')
        .select()
        .eq('id', id)
        .single();
    return FinacJournalEntryLine.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.journal_entry_lines').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.journal_entry_lines').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.journal_entry_lines').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacJournalEntryLineRepositoryProvider = Provider<FinacJournalEntryLineRepository>((ref) {
  return FinacJournalEntryLineRepository(Supabase.instance.client);
});

final finacJournalEntryLineListProvider = FutureProvider<List<FinacJournalEntryLine>>((ref) async {
  return ref.watch(finacJournalEntryLineRepositoryProvider).getAll();
});

final finacJournalEntryLineDetailProvider = FutureProvider.family<FinacJournalEntryLine, String>((ref, id) async {
  return ref.watch(finacJournalEntryLineRepositoryProvider).getById(id);
});
