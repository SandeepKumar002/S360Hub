import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_role_model.dart';

class LedgieModuleRoleRepository {
  final SupabaseClient _client;

  LedgieModuleRoleRepository(this._client);

  Future<List<LedgieModuleRole>> getAll() async {
    final response = await _client
        .from('ledgie.module_roles')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieModuleRole.fromJson(e)).toList();
  }

  Future<LedgieModuleRole> getById(String id) async {
    final response = await _client
        .from('ledgie.module_roles')
        .select()
        .eq('id', id)
        .single();
    return LedgieModuleRole.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.module_roles').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.module_roles').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.module_roles').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieModuleRoleRepositoryProvider = Provider<LedgieModuleRoleRepository>((ref) {
  return LedgieModuleRoleRepository(Supabase.instance.client);
});

final ledgieModuleRoleListProvider = FutureProvider<List<LedgieModuleRole>>((ref) async {
  return ref.watch(ledgieModuleRoleRepositoryProvider).getAll();
});

final ledgieModuleRoleDetailProvider = FutureProvider.family<LedgieModuleRole, String>((ref, id) async {
  return ref.watch(ledgieModuleRoleRepositoryProvider).getById(id);
});
