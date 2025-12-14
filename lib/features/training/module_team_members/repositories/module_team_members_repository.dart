import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_team_member_model.dart';

class TrainingModuleTeamMemberRepository {
  final SupabaseClient _client;

  TrainingModuleTeamMemberRepository(this._client);

  Future<List<TrainingModuleTeamMember>> getAll() async {
    final response = await _client
        .from('training.module_team_members')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingModuleTeamMember.fromJson(e)).toList();
  }

  Future<TrainingModuleTeamMember> getById(String id) async {
    final response = await _client
        .from('training.module_team_members')
        .select()
        .eq('id', id)
        .single();
    return TrainingModuleTeamMember.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.module_team_members').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.module_team_members').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.module_team_members').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingModuleTeamMemberRepositoryProvider = Provider<TrainingModuleTeamMemberRepository>((ref) {
  return TrainingModuleTeamMemberRepository(Supabase.instance.client);
});

final trainingModuleTeamMemberListProvider = FutureProvider<List<TrainingModuleTeamMember>>((ref) async {
  return ref.watch(trainingModuleTeamMemberRepositoryProvider).getAll();
});

final trainingModuleTeamMemberDetailProvider = FutureProvider.family<TrainingModuleTeamMember, String>((ref, id) async {
  return ref.watch(trainingModuleTeamMemberRepositoryProvider).getById(id);
});
