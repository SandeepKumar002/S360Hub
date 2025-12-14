import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_team_member_model.dart';

class SurveyModuleTeamMemberRepository {
  final SupabaseClient _client;

  SurveyModuleTeamMemberRepository(this._client);

  Future<List<SurveyModuleTeamMember>> getAll() async {
    final response = await _client
        .from('survey.module_team_members')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => SurveyModuleTeamMember.fromJson(e)).toList();
  }

  Future<SurveyModuleTeamMember> getById(String id) async {
    final response = await _client
        .from('survey.module_team_members')
        .select()
        .eq('id', id)
        .single();
    return SurveyModuleTeamMember.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('survey.module_team_members').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('survey.module_team_members').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('survey.module_team_members').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final surveyModuleTeamMemberRepositoryProvider = Provider<SurveyModuleTeamMemberRepository>((ref) {
  return SurveyModuleTeamMemberRepository(Supabase.instance.client);
});

final surveyModuleTeamMemberListProvider = FutureProvider<List<SurveyModuleTeamMember>>((ref) async {
  return ref.watch(surveyModuleTeamMemberRepositoryProvider).getAll();
});

final surveyModuleTeamMemberDetailProvider = FutureProvider.family<SurveyModuleTeamMember, String>((ref, id) async {
  return ref.watch(surveyModuleTeamMemberRepositoryProvider).getById(id);
});
