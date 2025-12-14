import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_team_member_model.dart';

class FinacModuleTeamMemberRepository {
  final SupabaseClient _client;

  FinacModuleTeamMemberRepository(this._client);

  Future<List<FinacModuleTeamMember>> getAll() async {
    final response = await _client
        .from('finac.module_team_members')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacModuleTeamMember.fromJson(e)).toList();
  }

  Future<FinacModuleTeamMember> getById(String id) async {
    final response = await _client
        .from('finac.module_team_members')
        .select()
        .eq('id', id)
        .single();
    return FinacModuleTeamMember.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.module_team_members').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.module_team_members').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.module_team_members').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacModuleTeamMemberRepositoryProvider = Provider<FinacModuleTeamMemberRepository>((ref) {
  return FinacModuleTeamMemberRepository(Supabase.instance.client);
});

final finacModuleTeamMemberListProvider = FutureProvider<List<FinacModuleTeamMember>>((ref) async {
  return ref.watch(finacModuleTeamMemberRepositoryProvider).getAll();
});

final finacModuleTeamMemberDetailProvider = FutureProvider.family<FinacModuleTeamMember, String>((ref, id) async {
  return ref.watch(finacModuleTeamMemberRepositoryProvider).getById(id);
});
