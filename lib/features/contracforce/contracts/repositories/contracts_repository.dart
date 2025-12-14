import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/contract_model.dart';

class ContracforceContractRepository {
  final SupabaseClient _client;

  ContracforceContractRepository(this._client);

  Future<List<ContracforceContract>> getAll() async {
    final response = await _client
        .from('contracforce.contracts')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ContracforceContract.fromJson(e)).toList();
  }

  Future<ContracforceContract> getById(String id) async {
    final response = await _client
        .from('contracforce.contracts')
        .select()
        .eq('id', id)
        .single();
    return ContracforceContract.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('contracforce.contracts').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('contracforce.contracts').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('contracforce.contracts').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final contracforceContractRepositoryProvider = Provider<ContracforceContractRepository>((ref) {
  return ContracforceContractRepository(Supabase.instance.client);
});

final contracforceContractListProvider = FutureProvider<List<ContracforceContract>>((ref) async {
  return ref.watch(contracforceContractRepositoryProvider).getAll();
});

final contracforceContractDetailProvider = FutureProvider.family<ContracforceContract, String>((ref, id) async {
  return ref.watch(contracforceContractRepositoryProvider).getById(id);
});
