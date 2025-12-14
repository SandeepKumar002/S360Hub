import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/access_control_models.dart';

class AccessControlRepository {
  final SupabaseClient _client;

  AccessControlRepository(this._client);

  // Users
  Future<List<ModuleUser>> getUsers() async {
    final response = await _client
        .from('nexus.module_users')
        .select()
        .order('display_name');
    return (response as List).map((e) => ModuleUser.fromJson(e)).toList();
  }

  Future<ModuleUser> getUserById(String id) async {
    final response = await _client
        .from('nexus.module_users')
        .select()
        .eq('id', id)
        .single();
    return ModuleUser.fromJson(response);
  }

  Future<void> createUser(Map<String, dynamic> data) async {
    await _client.from('nexus.module_users').insert(data);
  }
  
  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    await _client.from('nexus.module_users').update(data).eq('id', id);
  }

  Future<void> deleteUser(String id) async {
      // Soft delete
      await _client.from('nexus.module_users').update({
          'is_deleted': true, 
          'deleted_at': DateTime.now().toIso8601String()
      }).eq('id', id);
  }

  // Roles
  Future<List<ModuleRole>> getRoles() async {
    final response = await _client.from('nexus.module_roles').select().order('display_name');
    return (response as List).map((e) => ModuleRole.fromJson(e)).toList();
  }
  
  Future<ModuleRole> getRoleById(String id) async {
    final response = await _client.from('nexus.module_roles').select().eq('id', id).single();
    return ModuleRole.fromJson(response);
  }

  Future<void> createRole(Map<String, dynamic> data) async {
      await _client.from('nexus.module_roles').insert(data);
  }

  Future<void> updateRole(String id, Map<String, dynamic> data) async {
      await _client.from('nexus.module_roles').update(data).eq('id', id);
  }

  Future<void> deleteRole(String id) async {
      await _client.from('nexus.module_roles').delete().eq('id', id);
  }


  // Teams
  Future<List<ModuleTeam>> getTeams() async {
    final response = await _client.from('nexus.module_teams').select().order('team_name');
    return (response as List).map((e) => ModuleTeam.fromJson(e)).toList();
  }

  Future<ModuleTeam> getTeamById(String id) async {
     final response = await _client.from('nexus.module_teams').select().eq('id', id).single();
     return ModuleTeam.fromJson(response);
  }

  Future<void> createTeam(Map<String, dynamic> data) async {
      await _client.from('nexus.module_teams').insert(data);
  }
  
  Future<void> updateTeam(String id, Map<String, dynamic> data) async {
      await _client.from('nexus.module_teams').update(data).eq('id', id);
  }

  Future<void> deleteTeam(String id) async {
      await _client.from('nexus.module_teams').delete().eq('id', id);
  }
}

final accessControlRepositoryProvider = Provider<AccessControlRepository>((ref) {
  return AccessControlRepository(Supabase.instance.client);
});

final moduleUsersListProvider = FutureProvider<List<ModuleUser>>((ref) async {
  return ref.watch(accessControlRepositoryProvider).getUsers();
});

final moduleUserDetailProvider = FutureProvider.family<ModuleUser, String>((ref, id) async {
  return ref.watch(accessControlRepositoryProvider).getUserById(id);
});

final moduleRolesListProvider = FutureProvider<List<ModuleRole>>((ref) async {
  return ref.watch(accessControlRepositoryProvider).getRoles();
});

final moduleRoleDetailProvider = FutureProvider.family<ModuleRole, String>((ref, id) async {
  return ref.watch(accessControlRepositoryProvider).getRoleById(id);
});

final moduleTeamsListProvider = FutureProvider<List<ModuleTeam>>((ref) async {
  return ref.watch(accessControlRepositoryProvider).getTeams();
});

final moduleTeamDetailProvider = FutureProvider.family<ModuleTeam, String>((ref, id) async {
  return ref.watch(accessControlRepositoryProvider).getTeamById(id);
});
