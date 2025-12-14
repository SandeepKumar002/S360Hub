import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_role_assignment_model.dart';

class CommModuleRoleAssignmentRepository {
  final SupabaseClient _client;

  CommModuleRoleAssignmentRepository(this._client);

  Future<List<CommModuleRoleAssignment>> getAll() async {
    final response = await _client
        .from('comm.module_role_assignments')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommModuleRoleAssignment.fromJson(e)).toList();
  }

  Future<CommModuleRoleAssignment> getById(String id) async {
    final response = await _client
        .from('comm.module_role_assignments')
        .select()
        .eq('id', id)
        .single();
    return CommModuleRoleAssignment.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('comm.module_role_assignments').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('comm.module_role_assignments').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('comm.module_role_assignments').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final commModuleRoleAssignmentRepositoryProvider = Provider<CommModuleRoleAssignmentRepository>((ref) {
  return CommModuleRoleAssignmentRepository(Supabase.instance.client);
});

final commModuleRoleAssignmentListProvider = FutureProvider<List<CommModuleRoleAssignment>>((ref) async {
  return ref.watch(commModuleRoleAssignmentRepositoryProvider).getAll();
});

final commModuleRoleAssignmentDetailProvider = FutureProvider.family<CommModuleRoleAssignment, String>((ref, id) async {
  return ref.watch(commModuleRoleAssignmentRepositoryProvider).getById(id);
});
