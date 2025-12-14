import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_role_assignment_model.dart';

class SurveyModuleRoleAssignmentRepository {
  final SupabaseClient _client;

  SurveyModuleRoleAssignmentRepository(this._client);

  Future<List<SurveyModuleRoleAssignment>> getAll() async {
    final response = await _client
        .from('survey.module_role_assignments')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => SurveyModuleRoleAssignment.fromJson(e)).toList();
  }

  Future<SurveyModuleRoleAssignment> getById(String id) async {
    final response = await _client
        .from('survey.module_role_assignments')
        .select()
        .eq('id', id)
        .single();
    return SurveyModuleRoleAssignment.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('survey.module_role_assignments').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('survey.module_role_assignments').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('survey.module_role_assignments').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final surveyModuleRoleAssignmentRepositoryProvider = Provider<SurveyModuleRoleAssignmentRepository>((ref) {
  return SurveyModuleRoleAssignmentRepository(Supabase.instance.client);
});

final surveyModuleRoleAssignmentListProvider = FutureProvider<List<SurveyModuleRoleAssignment>>((ref) async {
  return ref.watch(surveyModuleRoleAssignmentRepositoryProvider).getAll();
});

final surveyModuleRoleAssignmentDetailProvider = FutureProvider.family<SurveyModuleRoleAssignment, String>((ref, id) async {
  return ref.watch(surveyModuleRoleAssignmentRepositoryProvider).getById(id);
});
