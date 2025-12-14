import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/module_user_model.dart';

class LedgieModuleUserRepository {
  final SupabaseClient _client;

  LedgieModuleUserRepository(this._client);

  Future<List<LedgieModuleUser>> getAll() async {
    final response = await _client
        .from('ledgie.module_users')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieModuleUser.fromJson(e)).toList();
  }

  Future<LedgieModuleUser> getById(String id) async {
    final response = await _client
        .from('ledgie.module_users')
        .select()
        .eq('id', id)
        .single();
    return LedgieModuleUser.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.module_users').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.module_users').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.module_users').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieModuleUserRepositoryProvider = Provider<LedgieModuleUserRepository>((ref) {
  return LedgieModuleUserRepository(Supabase.instance.client);
});

final ledgieModuleUserListProvider = FutureProvider<List<LedgieModuleUser>>((ref) async {
  return ref.watch(ledgieModuleUserRepositoryProvider).getAll();
});

final ledgieModuleUserDetailProvider = FutureProvider.family<LedgieModuleUser, String>((ref, id) async {
  return ref.watch(ledgieModuleUserRepositoryProvider).getById(id);
});
