import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/gst_transaction_model.dart';

class TaxforgeGstTransactionRepository {
  final SupabaseClient _client;

  TaxforgeGstTransactionRepository(this._client);

  Future<List<TaxforgeGstTransaction>> getAll() async {
    final response = await _client
        .from('taxforge.gst_transactions')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TaxforgeGstTransaction.fromJson(e)).toList();
  }

  Future<TaxforgeGstTransaction> getById(String id) async {
    final response = await _client
        .from('taxforge.gst_transactions')
        .select()
        .eq('id', id)
        .single();
    return TaxforgeGstTransaction.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('taxforge.gst_transactions').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('taxforge.gst_transactions').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('taxforge.gst_transactions').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final taxforgeGstTransactionRepositoryProvider = Provider<TaxforgeGstTransactionRepository>((ref) {
  return TaxforgeGstTransactionRepository(Supabase.instance.client);
});

final taxforgeGstTransactionListProvider = FutureProvider<List<TaxforgeGstTransaction>>((ref) async {
  return ref.watch(taxforgeGstTransactionRepositoryProvider).getAll();
});

final taxforgeGstTransactionDetailProvider = FutureProvider.family<TaxforgeGstTransaction, String>((ref, id) async {
  return ref.watch(taxforgeGstTransactionRepositoryProvider).getById(id);
});
