import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/hot_prospect_model.dart';

class LedgieHotProspectRepository {
  final SupabaseClient _client;

  LedgieHotProspectRepository(this._client);

  Future<List<LedgieHotProspect>> getAll() async {
    final response = await _client
        .from('ledgie.hot_prospects')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieHotProspect.fromJson(e)).toList();
  }

  Future<LedgieHotProspect> getById(String id) async {
    final response = await _client
        .from('ledgie.hot_prospects')
        .select()
        .eq('id', id)
        .single();
    return LedgieHotProspect.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.hot_prospects').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.hot_prospects').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.hot_prospects').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieHotProspectRepositoryProvider = Provider<LedgieHotProspectRepository>((ref) {
  return LedgieHotProspectRepository(Supabase.instance.client);
});

final ledgieHotProspectListProvider = FutureProvider<List<LedgieHotProspect>>((ref) async {
  return ref.watch(ledgieHotProspectRepositoryProvider).getAll();
});

final ledgieHotProspectDetailProvider = FutureProvider.family<LedgieHotProspect, String>((ref, id) async {
  return ref.watch(ledgieHotProspectRepositoryProvider).getById(id);
});
