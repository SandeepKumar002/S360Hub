import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/address_models.dart';

class AddressesRepository {
  final SupabaseClient _client;

  AddressesRepository(this._client);

  Future<List<Address>> getAddresses() async {
    final response = await _client
        .from('nexus.addresses')
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((e) => Address.fromJson(e)).toList();
  }

  Future<Address> getAddressById(String id) async {
    final response = await _client
        .from('nexus.addresses')
        .select()
        .eq('id', id)
        .single();
    return Address.fromJson(response);
  }

  Future<void> createAddress(Map<String, dynamic> data) async {
    await _client.from('nexus.addresses').insert(data);
  }

  Future<void> updateAddress(String id, Map<String, dynamic> data) async {
    await _client.from('nexus.addresses').update(data).eq('id', id);
  }

  Future<void> deleteAddress(String id) async {
    await _client.from('nexus.addresses').delete().eq('id', id);
  }
}

final addressesRepositoryProvider = Provider<AddressesRepository>((ref) {
  return AddressesRepository(Supabase.instance.client);
});

final addressesListProvider = FutureProvider<List<Address>>((ref) async {
  return ref.watch(addressesRepositoryProvider).getAddresses();
});

final addressDetailProvider = FutureProvider.family<Address, String>((ref, id) async {
  return ref.watch(addressesRepositoryProvider).getAddressById(id);
});
