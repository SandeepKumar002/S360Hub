import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_team_model.dart';

class FinacModuleTeamRepository {
  final SupabaseClient _client;

  FinacModuleTeamRepository(this._client);

  Future<List<FinacModuleTeam>> getAll() async {
    final response = await _client
        .from('finac.module_teams')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacModuleTeam.fromJson(e)).toList();
  }

  Future<FinacModuleTeam> getById(String id) async {
    final response = await _client
        .from('finac.module_teams')
        .select()
        .eq('id', id)
        .single();
    return FinacModuleTeam.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.module_teams').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.module_teams').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.module_teams').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacModuleTeamRepositoryProvider = Provider<FinacModuleTeamRepository>((ref) {
  return FinacModuleTeamRepository(Supabase.instance.client);
});

final finacModuleTeamListProvider = FutureProvider<List<FinacModuleTeam>>((ref) async {
  return ref.watch(finacModuleTeamRepositoryProvider).getAll();
});

final finacModuleTeamDetailProvider = FutureProvider.family<FinacModuleTeam, String>((ref, id) async {
  return ref.watch(finacModuleTeamRepositoryProvider).getById(id);
});
