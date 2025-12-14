import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/bank_account_model.dart';

class FinacBankAccountRepository {
  final SupabaseClient _client;

  FinacBankAccountRepository(this._client);

  Future<List<FinacBankAccount>> getAll() async {
    final response = await _client
        .from('finac.bank_accounts')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacBankAccount.fromJson(e)).toList();
  }

  Future<FinacBankAccount> getById(String id) async {
    final response = await _client
        .from('finac.bank_accounts')
        .select()
        .eq('id', id)
        .single();
    return FinacBankAccount.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.bank_accounts').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.bank_accounts').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.bank_accounts').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacBankAccountRepositoryProvider = Provider<FinacBankAccountRepository>((ref) {
  return FinacBankAccountRepository(Supabase.instance.client);
});

final finacBankAccountListProvider = FutureProvider<List<FinacBankAccount>>((ref) async {
  return ref.watch(finacBankAccountRepositoryProvider).getAll();
});

final finacBankAccountDetailProvider = FutureProvider.family<FinacBankAccount, String>((ref, id) async {
  return ref.watch(finacBankAccountRepositoryProvider).getById(id);
});
