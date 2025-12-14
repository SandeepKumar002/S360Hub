import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/entitie_model.dart';

class LedgieEntitieRepository {
  final SupabaseClient _client;

  LedgieEntitieRepository(this._client);

  Future<List<LedgieEntitie>> getAll() async {
    final response = await _client
        .from('ledgie.entities')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieEntitie.fromJson(e)).toList();
  }

  Future<LedgieEntitie> getById(String id) async {
    final response = await _client
        .from('ledgie.entities')
        .select()
        .eq('id', id)
        .single();
    return LedgieEntitie.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.entities').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.entities').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.entities').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieEntitieRepositoryProvider = Provider<LedgieEntitieRepository>((ref) {
  return LedgieEntitieRepository(Supabase.instance.client);
});

final ledgieEntitieListProvider = FutureProvider<List<LedgieEntitie>>((ref) async {
  return ref.watch(ledgieEntitieRepositoryProvider).getAll();
});

final ledgieEntitieDetailProvider = FutureProvider.family<LedgieEntitie, String>((ref, id) async {
  return ref.watch(ledgieEntitieRepositoryProvider).getById(id);
});
