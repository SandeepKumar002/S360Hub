import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/entity_contact_model.dart';

class LedgieEntityContactRepository {
  final SupabaseClient _client;

  LedgieEntityContactRepository(this._client);

  Future<List<LedgieEntityContact>> getAll() async {
    final response = await _client
        .from('ledgie.entity_contacts')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieEntityContact.fromJson(e)).toList();
  }

  Future<LedgieEntityContact> getById(String id) async {
    final response = await _client
        .from('ledgie.entity_contacts')
        .select()
        .eq('id', id)
        .single();
    return LedgieEntityContact.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.entity_contacts').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.entity_contacts').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.entity_contacts').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieEntityContactRepositoryProvider = Provider<LedgieEntityContactRepository>((ref) {
  return LedgieEntityContactRepository(Supabase.instance.client);
});

final ledgieEntityContactListProvider = FutureProvider<List<LedgieEntityContact>>((ref) async {
  return ref.watch(ledgieEntityContactRepositoryProvider).getAll();
});

final ledgieEntityContactDetailProvider = FutureProvider.family<LedgieEntityContact, String>((ref, id) async {
  return ref.watch(ledgieEntityContactRepositoryProvider).getById(id);
});
