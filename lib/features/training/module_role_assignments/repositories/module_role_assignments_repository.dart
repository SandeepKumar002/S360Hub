import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_role_assignment_model.dart';

class TrainingModuleRoleAssignmentRepository {
  final SupabaseClient _client;

  TrainingModuleRoleAssignmentRepository(this._client);

  Future<List<TrainingModuleRoleAssignment>> getAll() async {
    final response = await _client
        .from('training.module_role_assignments')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingModuleRoleAssignment.fromJson(e)).toList();
  }

  Future<TrainingModuleRoleAssignment> getById(String id) async {
    final response = await _client
        .from('training.module_role_assignments')
        .select()
        .eq('id', id)
        .single();
    return TrainingModuleRoleAssignment.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.module_role_assignments').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.module_role_assignments').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.module_role_assignments').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingModuleRoleAssignmentRepositoryProvider = Provider<TrainingModuleRoleAssignmentRepository>((ref) {
  return TrainingModuleRoleAssignmentRepository(Supabase.instance.client);
});

final trainingModuleRoleAssignmentListProvider = FutureProvider<List<TrainingModuleRoleAssignment>>((ref) async {
  return ref.watch(trainingModuleRoleAssignmentRepositoryProvider).getAll();
});

final trainingModuleRoleAssignmentDetailProvider = FutureProvider.family<TrainingModuleRoleAssignment, String>((ref, id) async {
  return ref.watch(trainingModuleRoleAssignmentRepositoryProvider).getById(id);
});
