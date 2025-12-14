import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/lookup_models.dart';

class LookupsRepository {
  final SupabaseClient _client;

  LookupsRepository(this._client);

  // Groups
  Future<List<LookupGroup>> getGroups() async {
    final response = await _client
        .from('nexus.lookup_groups')
        .select()
        .order('display_name');
    return (response as List).map((e) => LookupGroup.fromJson(e)).toList();
  }

  Future<LookupGroup> getGroupById(String id) async {
    final response = await _client
        .from('nexus.lookup_groups')
        .select()
        .eq('id', id)
        .single();
    return LookupGroup.fromJson(response);
  }

  Future<void> createGroup(Map<String, dynamic> data) async {
    await _client.from('nexus.lookup_groups').insert(data);
  }

  Future<void> updateGroup(String id, Map<String, dynamic> data) async {
    await _client.from('nexus.lookup_groups').update(data).eq('id', id);
  }
  
  Future<void> deleteGroup(String id) async {
     await _client.from('nexus.lookup_groups').delete().eq('id', id);
  }

  // Values
  Future<List<LookupValue>> getValuesByGroupId(String groupId) async {
    final response = await _client
        .from('nexus.lookup_values')
        .select()
        .eq('group_id', groupId)
        .order('sort_order');
    return (response as List).map((e) => LookupValue.fromJson(e)).toList();
  }
  
  Future<LookupValue> getValueById(String id) async {
      final response = await _client
        .from('nexus.lookup_values')
        .select()
        .eq('id', id)
        .single();
    return LookupValue.fromJson(response);
  }

  Future<void> createValue(Map<String, dynamic> data) async {
    await _client.from('nexus.lookup_values').insert(data);
  }

  Future<void> updateValue(String id, Map<String, dynamic> data) async {
    await _client.from('nexus.lookup_values').update(data).eq('id', id);
  }

  Future<void> deleteValue(String id) async {
    await _client.from('nexus.lookup_values').delete().eq('id', id);
  }
}

final lookupsRepositoryProvider = Provider<LookupsRepository>((ref) {
  return LookupsRepository(Supabase.instance.client);
});

final lookupGroupsListProvider = FutureProvider<List<LookupGroup>>((ref) async {
  return ref.watch(lookupsRepositoryProvider).getGroups();
});

final lookupGroupDetailProvider = FutureProvider.family<LookupGroup, String>((ref, id) async {
  return ref.watch(lookupsRepositoryProvider).getGroupById(id);
});

final lookupValuesListProvider = FutureProvider.family<List<LookupValue>, String>((ref, groupId) async {
  return ref.watch(lookupsRepositoryProvider).getValuesByGroupId(groupId);
});
