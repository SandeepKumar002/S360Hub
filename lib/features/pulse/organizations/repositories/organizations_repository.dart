import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/organization_model.dart';

class OrganizationsRepository {
  final SupabaseClient _client;

  OrganizationsRepository(this._client);

  Future<List<Organization>> getOrganizations() async {
    final response = await _client
        .from('pulse.organizations')
        .select()
        .filter('deleted_at', 'is', null) // Fixed: is_ -> filter(..., 'is', null)
        .order('name');
    return (response as List).map((e) => Organization.fromJson(e)).toList();
  }

  Future<Organization> getOrganizationById(String id) async {
    final response = await _client
        .from('pulse.organizations')
        .select()
        .eq('id', id)
        .single();
    return Organization.fromJson(response);
  }

  Future<void> createOrganization(Map<String, dynamic> data) async {
    await _client.from('pulse.organizations').insert(data);
  }

  Future<void> updateOrganization(String id, Map<String, dynamic> data) async {
    await _client.from('pulse.organizations').update(data).eq('id', id);
  }

  Future<void> deleteOrganization(String id) async {
    // Soft delete
    await _client.from('pulse.organizations').update({
      'deleted_at': DateTime.now().toIso8601String(),
    }).eq('id', id);
  }
}

final organizationsRepositoryProvider = Provider<OrganizationsRepository>((ref) {
  return OrganizationsRepository(Supabase.instance.client);
});

final organizationsListProvider = FutureProvider<List<Organization>>((ref) async {
  return ref.watch(organizationsRepositoryProvider).getOrganizations();
});

final organizationDetailProvider = FutureProvider.family<Organization, String>((ref, id) async {
  return ref.watch(organizationsRepositoryProvider).getOrganizationById(id);
});
