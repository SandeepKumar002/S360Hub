import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/active_customer_model.dart';

class LedgieActiveCustomerRepository {
  final SupabaseClient _client;

  LedgieActiveCustomerRepository(this._client);

  Future<List<LedgieActiveCustomer>> getAll() async {
    final response = await _client
        .from('ledgie.active_customers')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieActiveCustomer.fromJson(e)).toList();
  }

  Future<LedgieActiveCustomer> getById(String id) async {
    final response = await _client
        .from('ledgie.active_customers')
        .select()
        .eq('id', id)
        .single();
    return LedgieActiveCustomer.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.active_customers').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.active_customers').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.active_customers').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieActiveCustomerRepositoryProvider = Provider<LedgieActiveCustomerRepository>((ref) {
  return LedgieActiveCustomerRepository(Supabase.instance.client);
});

final ledgieActiveCustomerListProvider = FutureProvider<List<LedgieActiveCustomer>>((ref) async {
  return ref.watch(ledgieActiveCustomerRepositoryProvider).getAll();
});

final ledgieActiveCustomerDetailProvider = FutureProvider.family<LedgieActiveCustomer, String>((ref, id) async {
  return ref.watch(ledgieActiveCustomerRepositoryProvider).getById(id);
});
