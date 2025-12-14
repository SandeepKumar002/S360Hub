import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_role_assignment_model.dart';

class KnowledgeModuleRoleAssignmentRepository {
  final SupabaseClient _client;

  KnowledgeModuleRoleAssignmentRepository(this._client);

  Future<List<KnowledgeModuleRoleAssignment>> getAll() async {
    final response = await _client
        .from('knowledge.module_role_assignments')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => KnowledgeModuleRoleAssignment.fromJson(e)).toList();
  }

  Future<KnowledgeModuleRoleAssignment> getById(String id) async {
    final response = await _client
        .from('knowledge.module_role_assignments')
        .select()
        .eq('id', id)
        .single();
    return KnowledgeModuleRoleAssignment.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('knowledge.module_role_assignments').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('knowledge.module_role_assignments').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('knowledge.module_role_assignments').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final knowledgeModuleRoleAssignmentRepositoryProvider = Provider<KnowledgeModuleRoleAssignmentRepository>((ref) {
  return KnowledgeModuleRoleAssignmentRepository(Supabase.instance.client);
});

final knowledgeModuleRoleAssignmentListProvider = FutureProvider<List<KnowledgeModuleRoleAssignment>>((ref) async {
  return ref.watch(knowledgeModuleRoleAssignmentRepositoryProvider).getAll();
});

final knowledgeModuleRoleAssignmentDetailProvider = FutureProvider.family<KnowledgeModuleRoleAssignment, String>((ref, id) async {
  return ref.watch(knowledgeModuleRoleAssignmentRepositoryProvider).getById(id);
});
