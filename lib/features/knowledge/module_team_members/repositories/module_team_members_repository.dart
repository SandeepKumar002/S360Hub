import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_team_member_model.dart';

class KnowledgeModuleTeamMemberRepository {
  final SupabaseClient _client;

  KnowledgeModuleTeamMemberRepository(this._client);

  Future<List<KnowledgeModuleTeamMember>> getAll() async {
    final response = await _client
        .from('knowledge.module_team_members')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => KnowledgeModuleTeamMember.fromJson(e)).toList();
  }

  Future<KnowledgeModuleTeamMember> getById(String id) async {
    final response = await _client
        .from('knowledge.module_team_members')
        .select()
        .eq('id', id)
        .single();
    return KnowledgeModuleTeamMember.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('knowledge.module_team_members').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('knowledge.module_team_members').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('knowledge.module_team_members').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final knowledgeModuleTeamMemberRepositoryProvider = Provider<KnowledgeModuleTeamMemberRepository>((ref) {
  return KnowledgeModuleTeamMemberRepository(Supabase.instance.client);
});

final knowledgeModuleTeamMemberListProvider = FutureProvider<List<KnowledgeModuleTeamMember>>((ref) async {
  return ref.watch(knowledgeModuleTeamMemberRepositoryProvider).getAll();
});

final knowledgeModuleTeamMemberDetailProvider = FutureProvider.family<KnowledgeModuleTeamMember, String>((ref, id) async {
  return ref.watch(knowledgeModuleTeamMemberRepositoryProvider).getById(id);
});
