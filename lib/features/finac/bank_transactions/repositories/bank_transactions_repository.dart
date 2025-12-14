import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/bank_transaction_model.dart';

class FinacBankTransactionRepository {
  final SupabaseClient _client;

  FinacBankTransactionRepository(this._client);

  Future<List<FinacBankTransaction>> getAll() async {
    final response = await _client
        .from('finac.bank_transactions')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacBankTransaction.fromJson(e)).toList();
  }

  Future<FinacBankTransaction> getById(String id) async {
    final response = await _client
        .from('finac.bank_transactions')
        .select()
        .eq('id', id)
        .single();
    return FinacBankTransaction.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.bank_transactions').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.bank_transactions').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.bank_transactions').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacBankTransactionRepositoryProvider = Provider<FinacBankTransactionRepository>((ref) {
  return FinacBankTransactionRepository(Supabase.instance.client);
});

final finacBankTransactionListProvider = FutureProvider<List<FinacBankTransaction>>((ref) async {
  return ref.watch(finacBankTransactionRepositoryProvider).getAll();
});

final finacBankTransactionDetailProvider = FutureProvider.family<FinacBankTransaction, String>((ref, id) async {
  return ref.watch(finacBankTransactionRepositoryProvider).getById(id);
});
