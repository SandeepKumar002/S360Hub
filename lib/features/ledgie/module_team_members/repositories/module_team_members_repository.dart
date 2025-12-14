import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_team_member_model.dart';

class LedgieModuleTeamMemberRepository {
  final SupabaseClient _client;

  LedgieModuleTeamMemberRepository(this._client);

  Future<List<LedgieModuleTeamMember>> getAll() async {
    final response = await _client
        .from('ledgie.module_team_members')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieModuleTeamMember.fromJson(e)).toList();
  }

  Future<LedgieModuleTeamMember> getById(String id) async {
    final response = await _client
        .from('ledgie.module_team_members')
        .select()
        .eq('id', id)
        .single();
    return LedgieModuleTeamMember.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.module_team_members').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.module_team_members').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.module_team_members').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieModuleTeamMemberRepositoryProvider = Provider<LedgieModuleTeamMemberRepository>((ref) {
  return LedgieModuleTeamMemberRepository(Supabase.instance.client);
});

final ledgieModuleTeamMemberListProvider = FutureProvider<List<LedgieModuleTeamMember>>((ref) async {
  return ref.watch(ledgieModuleTeamMemberRepositoryProvider).getAll();
});

final ledgieModuleTeamMemberDetailProvider = FutureProvider.family<LedgieModuleTeamMember, String>((ref, id) async {
  return ref.watch(ledgieModuleTeamMemberRepositoryProvider).getById(id);
});
