import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/ppe_returned_model.dart';

class ShieldPpeReturnedRepository {
  final SupabaseClient _client;

  ShieldPpeReturnedRepository(this._client);

  Future<List<ShieldPpeReturned>> getAll() async {
    final response = await _client
        .from('shield.ppe_returned')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ShieldPpeReturned.fromJson(e)).toList();
  }

  Future<ShieldPpeReturned> getById(String id) async {
    final response = await _client
        .from('shield.ppe_returned')
        .select()
        .eq('id', id)
        .single();
    return ShieldPpeReturned.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('shield.ppe_returned').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('shield.ppe_returned').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('shield.ppe_returned').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final shieldPpeReturnedRepositoryProvider = Provider<ShieldPpeReturnedRepository>((ref) {
  return ShieldPpeReturnedRepository(Supabase.instance.client);
});

final shieldPpeReturnedListProvider = FutureProvider<List<ShieldPpeReturned>>((ref) async {
  return ref.watch(shieldPpeReturnedRepositoryProvider).getAll();
});

final shieldPpeReturnedDetailProvider = FutureProvider.family<ShieldPpeReturned, String>((ref, id) async {
  return ref.watch(shieldPpeReturnedRepositoryProvider).getById(id);
});
