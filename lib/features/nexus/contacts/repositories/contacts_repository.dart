import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/contact_models.dart';

class ContactsRepository {
  final SupabaseClient _client;

  ContactsRepository(this._client);

  Future<List<Contact>> getContacts() async {
    final response = await _client
        .from('nexus.contacts')
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((e) => Contact.fromJson(e)).toList();
  }

  Future<Contact> getContactById(String id) async {
    final response = await _client
        .from('nexus.contacts')
        .select()
        .eq('id', id)
        .single();
    return Contact.fromJson(response);
  }

  Future<void> createContact(Map<String, dynamic> data) async {
    await _client.from('nexus.contacts').insert(data);
  }

  Future<void> updateContact(String id, Map<String, dynamic> data) async {
    await _client.from('nexus.contacts').update(data).eq('id', id);
  }

  Future<void> deleteContact(String id) async {
    await _client.from('nexus.contacts').delete().eq('id', id);
  }
}

final contactsRepositoryProvider = Provider<ContactsRepository>((ref) {
  return ContactsRepository(Supabase.instance.client);
});

final contactsListProvider = FutureProvider<List<Contact>>((ref) async {
  return ref.watch(contactsRepositoryProvider).getContacts();
});

final contactDetailProvider = FutureProvider.family<Contact, String>((ref, id) async {
  return ref.watch(contactsRepositoryProvider).getContactById(id);
});
