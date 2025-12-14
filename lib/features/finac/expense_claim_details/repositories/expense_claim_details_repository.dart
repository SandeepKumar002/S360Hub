import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/expense_claim_detail_model.dart';

class FinacExpenseClaimDetailRepository {
  final SupabaseClient _client;

  FinacExpenseClaimDetailRepository(this._client);

  Future<List<FinacExpenseClaimDetail>> getAll() async {
    final response = await _client
        .from('finac.expense_claim_details')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacExpenseClaimDetail.fromJson(e)).toList();
  }

  Future<FinacExpenseClaimDetail> getById(String id) async {
    final response = await _client
        .from('finac.expense_claim_details')
        .select()
        .eq('id', id)
        .single();
    return FinacExpenseClaimDetail.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.expense_claim_details').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.expense_claim_details').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.expense_claim_details').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacExpenseClaimDetailRepositoryProvider = Provider<FinacExpenseClaimDetailRepository>((ref) {
  return FinacExpenseClaimDetailRepository(Supabase.instance.client);
});

final finacExpenseClaimDetailListProvider = FutureProvider<List<FinacExpenseClaimDetail>>((ref) async {
  return ref.watch(finacExpenseClaimDetailRepositoryProvider).getAll();
});

final finacExpenseClaimDetailDetailProvider = FutureProvider.family<FinacExpenseClaimDetail, String>((ref, id) async {
  return ref.watch(finacExpenseClaimDetailRepositoryProvider).getById(id);
});
