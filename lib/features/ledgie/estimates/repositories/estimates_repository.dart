import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/estimate_model.dart';

class LedgieEstimateRepository {
  final SupabaseClient _client;

  LedgieEstimateRepository(this._client);

  Future<List<LedgieEstimate>> getAll() async {
    final response = await _client
        .from('ledgie.estimates')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieEstimate.fromJson(e)).toList();
  }

  Future<LedgieEstimate> getById(String id) async {
    final response = await _client
        .from('ledgie.estimates')
        .select()
        .eq('id', id)
        .single();
    return LedgieEstimate.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.estimates').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.estimates').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.estimates').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieEstimateRepositoryProvider = Provider<LedgieEstimateRepository>((ref) {
  return LedgieEstimateRepository(Supabase.instance.client);
});

final ledgieEstimateListProvider = FutureProvider<List<LedgieEstimate>>((ref) async {
  return ref.watch(ledgieEstimateRepositoryProvider).getAll();
});

final ledgieEstimateDetailProvider = FutureProvider.family<LedgieEstimate, String>((ref, id) async {
  return ref.watch(ledgieEstimateRepositoryProvider).getById(id);
});
