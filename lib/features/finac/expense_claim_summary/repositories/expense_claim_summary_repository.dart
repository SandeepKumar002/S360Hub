import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/expense_claim_summary_model.dart';

class FinacExpenseClaimSummaryRepository {
  final SupabaseClient _client;

  FinacExpenseClaimSummaryRepository(this._client);

  Future<List<FinacExpenseClaimSummary>> getAll() async {
    final response = await _client
        .from('finac.expense_claim_summary')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacExpenseClaimSummary.fromJson(e)).toList();
  }

  Future<FinacExpenseClaimSummary> getById(String id) async {
    final response = await _client
        .from('finac.expense_claim_summary')
        .select()
        .eq('id', id)
        .single();
    return FinacExpenseClaimSummary.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.expense_claim_summary').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.expense_claim_summary').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.expense_claim_summary').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacExpenseClaimSummaryRepositoryProvider = Provider<FinacExpenseClaimSummaryRepository>((ref) {
  return FinacExpenseClaimSummaryRepository(Supabase.instance.client);
});

final finacExpenseClaimSummaryListProvider = FutureProvider<List<FinacExpenseClaimSummary>>((ref) async {
  return ref.watch(finacExpenseClaimSummaryRepositoryProvider).getAll();
});

final finacExpenseClaimSummaryDetailProvider = FutureProvider.family<FinacExpenseClaimSummary, String>((ref, id) async {
  return ref.watch(finacExpenseClaimSummaryRepositoryProvider).getById(id);
});
