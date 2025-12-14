import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/active_prospect_model.dart';

class LedgieActiveProspectRepository {
  final SupabaseClient _client;

  LedgieActiveProspectRepository(this._client);

  Future<List<LedgieActiveProspect>> getAll() async {
    final response = await _client
        .from('ledgie.active_prospects')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieActiveProspect.fromJson(e)).toList();
  }

  Future<LedgieActiveProspect> getById(String id) async {
    final response = await _client
        .from('ledgie.active_prospects')
        .select()
        .eq('id', id)
        .single();
    return LedgieActiveProspect.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.active_prospects').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.active_prospects').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.active_prospects').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieActiveProspectRepositoryProvider = Provider<LedgieActiveProspectRepository>((ref) {
  return LedgieActiveProspectRepository(Supabase.instance.client);
});

final ledgieActiveProspectListProvider = FutureProvider<List<LedgieActiveProspect>>((ref) async {
  return ref.watch(ledgieActiveProspectRepositoryProvider).getAll();
});

final ledgieActiveProspectDetailProvider = FutureProvider.family<LedgieActiveProspect, String>((ref, id) async {
  return ref.watch(ledgieActiveProspectRepositoryProvider).getById(id);
});
