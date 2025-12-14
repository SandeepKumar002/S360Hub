import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/ppe_issued_model.dart';

class ShieldPpeIssuedRepository {
  final SupabaseClient _client;

  ShieldPpeIssuedRepository(this._client);

  Future<List<ShieldPpeIssued>> getAll() async {
    final response = await _client
        .from('shield.ppe_issued')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ShieldPpeIssued.fromJson(e)).toList();
  }

  Future<ShieldPpeIssued> getById(String id) async {
    final response = await _client
        .from('shield.ppe_issued')
        .select()
        .eq('id', id)
        .single();
    return ShieldPpeIssued.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('shield.ppe_issued').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('shield.ppe_issued').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('shield.ppe_issued').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final shieldPpeIssuedRepositoryProvider = Provider<ShieldPpeIssuedRepository>((ref) {
  return ShieldPpeIssuedRepository(Supabase.instance.client);
});

final shieldPpeIssuedListProvider = FutureProvider<List<ShieldPpeIssued>>((ref) async {
  return ref.watch(shieldPpeIssuedRepositoryProvider).getAll();
});

final shieldPpeIssuedDetailProvider = FutureProvider.family<ShieldPpeIssued, String>((ref, id) async {
  return ref.watch(shieldPpeIssuedRepositoryProvider).getById(id);
});
