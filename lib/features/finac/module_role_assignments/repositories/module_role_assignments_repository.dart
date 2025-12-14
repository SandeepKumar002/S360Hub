import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_role_assignment_model.dart';

class FinacModuleRoleAssignmentRepository {
  final SupabaseClient _client;

  FinacModuleRoleAssignmentRepository(this._client);

  Future<List<FinacModuleRoleAssignment>> getAll() async {
    final response = await _client
        .from('finac.module_role_assignments')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacModuleRoleAssignment.fromJson(e)).toList();
  }

  Future<FinacModuleRoleAssignment> getById(String id) async {
    final response = await _client
        .from('finac.module_role_assignments')
        .select()
        .eq('id', id)
        .single();
    return FinacModuleRoleAssignment.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.module_role_assignments').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.module_role_assignments').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.module_role_assignments').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacModuleRoleAssignmentRepositoryProvider = Provider<FinacModuleRoleAssignmentRepository>((ref) {
  return FinacModuleRoleAssignmentRepository(Supabase.instance.client);
});

final finacModuleRoleAssignmentListProvider = FutureProvider<List<FinacModuleRoleAssignment>>((ref) async {
  return ref.watch(finacModuleRoleAssignmentRepositoryProvider).getAll();
});

final finacModuleRoleAssignmentDetailProvider = FutureProvider.family<FinacModuleRoleAssignment, String>((ref, id) async {
  return ref.watch(finacModuleRoleAssignmentRepositoryProvider).getById(id);
});
