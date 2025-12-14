import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/contract_payment_model.dart';

class ContracforceContractPaymentRepository {
  final SupabaseClient _client;

  ContracforceContractPaymentRepository(this._client);

  Future<List<ContracforceContractPayment>> getAll() async {
    final response = await _client
        .from('contracforce.contract_payments')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ContracforceContractPayment.fromJson(e)).toList();
  }

  Future<ContracforceContractPayment> getById(String id) async {
    final response = await _client
        .from('contracforce.contract_payments')
        .select()
        .eq('id', id)
        .single();
    return ContracforceContractPayment.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('contracforce.contract_payments').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('contracforce.contract_payments').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('contracforce.contract_payments').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final contracforceContractPaymentRepositoryProvider = Provider<ContracforceContractPaymentRepository>((ref) {
  return ContracforceContractPaymentRepository(Supabase.instance.client);
});

final contracforceContractPaymentListProvider = FutureProvider<List<ContracforceContractPayment>>((ref) async {
  return ref.watch(contracforceContractPaymentRepositoryProvider).getAll();
});

final contracforceContractPaymentDetailProvider = FutureProvider.family<ContracforceContractPayment, String>((ref, id) async {
  return ref.watch(contracforceContractPaymentRepositoryProvider).getById(id);
});
