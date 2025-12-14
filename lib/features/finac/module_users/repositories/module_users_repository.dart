import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_user_model.dart';

class FinacModuleUserRepository {
  final SupabaseClient _client;

  FinacModuleUserRepository(this._client);

  Future<List<FinacModuleUser>> getAll() async {
    final response = await _client
        .from('finac.module_users')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacModuleUser.fromJson(e)).toList();
  }

  Future<FinacModuleUser> getById(String id) async {
    final response = await _client
        .from('finac.module_users')
        .select()
        .eq('id', id)
        .single();
    return FinacModuleUser.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.module_users').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.module_users').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.module_users').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacModuleUserRepositoryProvider = Provider<FinacModuleUserRepository>((ref) {
  return FinacModuleUserRepository(Supabase.instance.client);
});

final finacModuleUserListProvider = FutureProvider<List<FinacModuleUser>>((ref) async {
  return ref.watch(finacModuleUserRepositoryProvider).getAll();
});

final finacModuleUserDetailProvider = FutureProvider.family<FinacModuleUser, String>((ref, id) async {
  return ref.watch(finacModuleUserRepositoryProvider).getById(id);
});
