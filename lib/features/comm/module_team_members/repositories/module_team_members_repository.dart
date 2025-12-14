import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_team_member_model.dart';

class CommModuleTeamMemberRepository {
  final SupabaseClient _client;

  CommModuleTeamMemberRepository(this._client);

  Future<List<CommModuleTeamMember>> getAll() async {
    final response = await _client
        .from('comm.module_team_members')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommModuleTeamMember.fromJson(e)).toList();
  }

  Future<CommModuleTeamMember> getById(String id) async {
    final response = await _client
        .from('comm.module_team_members')
        .select()
        .eq('id', id)
        .single();
    return CommModuleTeamMember.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('comm.module_team_members').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('comm.module_team_members').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('comm.module_team_members').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final commModuleTeamMemberRepositoryProvider = Provider<CommModuleTeamMemberRepository>((ref) {
  return CommModuleTeamMemberRepository(Supabase.instance.client);
});

final commModuleTeamMemberListProvider = FutureProvider<List<CommModuleTeamMember>>((ref) async {
  return ref.watch(commModuleTeamMemberRepositoryProvider).getAll();
});

final commModuleTeamMemberDetailProvider = FutureProvider.family<CommModuleTeamMember, String>((ref, id) async {
  return ref.watch(commModuleTeamMemberRepositoryProvider).getById(id);
});
