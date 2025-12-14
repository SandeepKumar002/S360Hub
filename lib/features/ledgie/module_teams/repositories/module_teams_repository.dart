import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_team_model.dart';

class LedgieModuleTeamRepository {
  final SupabaseClient _client;

  LedgieModuleTeamRepository(this._client);

  Future<List<LedgieModuleTeam>> getAll() async {
    final response = await _client
        .from('ledgie.module_teams')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieModuleTeam.fromJson(e)).toList();
  }

  Future<LedgieModuleTeam> getById(String id) async {
    final response = await _client
        .from('ledgie.module_teams')
        .select()
        .eq('id', id)
        .single();
    return LedgieModuleTeam.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.module_teams').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.module_teams').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.module_teams').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieModuleTeamRepositoryProvider = Provider<LedgieModuleTeamRepository>((ref) {
  return LedgieModuleTeamRepository(Supabase.instance.client);
});

final ledgieModuleTeamListProvider = FutureProvider<List<LedgieModuleTeam>>((ref) async {
  return ref.watch(ledgieModuleTeamRepositoryProvider).getAll();
});

final ledgieModuleTeamDetailProvider = FutureProvider.family<LedgieModuleTeam, String>((ref, id) async {
  return ref.watch(ledgieModuleTeamRepositoryProvider).getById(id);
});
