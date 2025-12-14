import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/contract_model.dart';

class ContractsRepository {
  final SupabaseClient _client;

  ContractsRepository(this._client);

  Future<List<EmploymentContract>> getContracts() async {
    final response = await _client
        .from('staffie.contracts')
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((e) => EmploymentContract.fromJson(e)).toList();
  }

  Future<void> createContract(Map<String, dynamic> data) async {
    await _client.from('staffie.contracts').insert(data);
  }
}

final contractsRepositoryProvider = Provider<ContractsRepository>((ref) {
  return ContractsRepository(Supabase.instance.client);
});

final contractsListProvider = FutureProvider<List<EmploymentContract>>((ref) async {
  return ref.watch(contractsRepositoryProvider).getContracts();
});
