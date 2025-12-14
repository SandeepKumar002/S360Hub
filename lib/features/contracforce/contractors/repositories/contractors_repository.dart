import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/contractor_model.dart';

class ContracforceContractorRepository {
  final SupabaseClient _client;

  ContracforceContractorRepository(this._client);

  Future<List<ContracforceContractor>> getAll() async {
    final response = await _client
        .from('contracforce.contractors')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ContracforceContractor.fromJson(e)).toList();
  }

  Future<ContracforceContractor> getById(String id) async {
    final response = await _client
        .from('contracforce.contractors')
        .select()
        .eq('id', id)
        .single();
    return ContracforceContractor.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('contracforce.contractors').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('contracforce.contractors').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('contracforce.contractors').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final contracforceContractorRepositoryProvider = Provider<ContracforceContractorRepository>((ref) {
  return ContracforceContractorRepository(Supabase.instance.client);
});

final contracforceContractorListProvider = FutureProvider<List<ContracforceContractor>>((ref) async {
  return ref.watch(contracforceContractorRepositoryProvider).getAll();
});

final contracforceContractorDetailProvider = FutureProvider.family<ContracforceContractor, String>((ref, id) async {
  return ref.watch(contracforceContractorRepositoryProvider).getById(id);
});
