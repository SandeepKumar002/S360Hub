import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/person_model.dart';

class PersonsRepository {
  final SupabaseClient _client;

  PersonsRepository(this._client);

  Future<List<Person>> getPersons() async {
    final response = await _client
        .from('nexus.persons')
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((e) => Person.fromJson(e)).toList();
  }

  Future<Person> getPersonById(String id) async {
    final response = await _client
        .from('nexus.persons')
        .select()
        .eq('id', id)
        .single();
    return Person.fromJson(response);
  }

  Future<void> createPerson(Map<String, dynamic> data) async {
    await _client.from('nexus.persons').insert(data);
  }

  Future<void> updatePerson(String id, Map<String, dynamic> data) async {
    await _client.from('nexus.persons').update(data).eq('id', id);
  }

  Future<void> deletePerson(String id) async {
    // Soft delete usually? Schema showed deleted_at. 
    // Implementing Update deleted_at for now if logic requires, or hard delete row.
    // Schema had 'deleted_at', implying soft delete.
    await _client.from('nexus.persons').update({
      'deleted_at': DateTime.now().toIso8601String(),
    }).eq('id', id);
  }
}

final personsRepositoryProvider = Provider<PersonsRepository>((ref) {
  return PersonsRepository(Supabase.instance.client);
});

final personsListProvider = FutureProvider<List<Person>>((ref) async {
  return ref.watch(personsRepositoryProvider).getPersons();
});

final personDetailProvider = FutureProvider.family<Person, String>((ref, id) async {
  return ref.watch(personsRepositoryProvider).getPersonById(id);
});
