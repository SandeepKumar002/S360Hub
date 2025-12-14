import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_role_assignment_model.dart';

class LedgieModuleRoleAssignmentRepository {
  final SupabaseClient _client;

  LedgieModuleRoleAssignmentRepository(this._client);

  Future<List<LedgieModuleRoleAssignment>> getAll() async {
    final response = await _client
        .from('ledgie.module_role_assignments')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieModuleRoleAssignment.fromJson(e)).toList();
  }

  Future<LedgieModuleRoleAssignment> getById(String id) async {
    final response = await _client
        .from('ledgie.module_role_assignments')
        .select()
        .eq('id', id)
        .single();
    return LedgieModuleRoleAssignment.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.module_role_assignments').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.module_role_assignments').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.module_role_assignments').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieModuleRoleAssignmentRepositoryProvider = Provider<LedgieModuleRoleAssignmentRepository>((ref) {
  return LedgieModuleRoleAssignmentRepository(Supabase.instance.client);
});

final ledgieModuleRoleAssignmentListProvider = FutureProvider<List<LedgieModuleRoleAssignment>>((ref) async {
  return ref.watch(ledgieModuleRoleAssignmentRepositoryProvider).getAll();
});

final ledgieModuleRoleAssignmentDetailProvider = FutureProvider.family<LedgieModuleRoleAssignment, String>((ref, id) async {
  return ref.watch(ledgieModuleRoleAssignmentRepositoryProvider).getById(id);
});
