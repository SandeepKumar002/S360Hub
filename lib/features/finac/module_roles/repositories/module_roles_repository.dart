import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_role_model.dart';

class FinacModuleRoleRepository {
  final SupabaseClient _client;

  FinacModuleRoleRepository(this._client);

  Future<List<FinacModuleRole>> getAll() async {
    final response = await _client
        .from('finac.module_roles')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacModuleRole.fromJson(e)).toList();
  }

  Future<FinacModuleRole> getById(String id) async {
    final response = await _client
        .from('finac.module_roles')
        .select()
        .eq('id', id)
        .single();
    return FinacModuleRole.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.module_roles').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.module_roles').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.module_roles').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacModuleRoleRepositoryProvider = Provider<FinacModuleRoleRepository>((ref) {
  return FinacModuleRoleRepository(Supabase.instance.client);
});

final finacModuleRoleListProvider = FutureProvider<List<FinacModuleRole>>((ref) async {
  return ref.watch(finacModuleRoleRepositoryProvider).getAll();
});

final finacModuleRoleDetailProvider = FutureProvider.family<FinacModuleRole, String>((ref, id) async {
  return ref.watch(finacModuleRoleRepositoryProvider).getById(id);
});
