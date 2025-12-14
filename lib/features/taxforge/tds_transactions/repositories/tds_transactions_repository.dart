import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tds_transaction_model.dart';

class TaxforgeTdsTransactionRepository {
  final SupabaseClient _client;

  TaxforgeTdsTransactionRepository(this._client);

  Future<List<TaxforgeTdsTransaction>> getAll() async {
    final response = await _client
        .from('taxforge.tds_transactions')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TaxforgeTdsTransaction.fromJson(e)).toList();
  }

  Future<TaxforgeTdsTransaction> getById(String id) async {
    final response = await _client
        .from('taxforge.tds_transactions')
        .select()
        .eq('id', id)
        .single();
    return TaxforgeTdsTransaction.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('taxforge.tds_transactions').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('taxforge.tds_transactions').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('taxforge.tds_transactions').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final taxforgeTdsTransactionRepositoryProvider = Provider<TaxforgeTdsTransactionRepository>((ref) {
  return TaxforgeTdsTransactionRepository(Supabase.instance.client);
});

final taxforgeTdsTransactionListProvider = FutureProvider<List<TaxforgeTdsTransaction>>((ref) async {
  return ref.watch(taxforgeTdsTransactionRepositoryProvider).getAll();
});

final taxforgeTdsTransactionDetailProvider = FutureProvider.family<TaxforgeTdsTransaction, String>((ref, id) async {
  return ref.watch(taxforgeTdsTransactionRepositoryProvider).getById(id);
});
