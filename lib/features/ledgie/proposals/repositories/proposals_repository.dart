import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/proposal_model.dart';

class LedgieProposalRepository {
  final SupabaseClient _client;

  LedgieProposalRepository(this._client);

  Future<List<LedgieProposal>> getAll() async {
    final response = await _client
        .from('ledgie.proposals')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieProposal.fromJson(e)).toList();
  }

  Future<LedgieProposal> getById(String id) async {
    final response = await _client
        .from('ledgie.proposals')
        .select()
        .eq('id', id)
        .single();
    return LedgieProposal.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.proposals').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.proposals').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.proposals').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieProposalRepositoryProvider = Provider<LedgieProposalRepository>((ref) {
  return LedgieProposalRepository(Supabase.instance.client);
});

final ledgieProposalListProvider = FutureProvider<List<LedgieProposal>>((ref) async {
  return ref.watch(ledgieProposalRepositoryProvider).getAll();
});

final ledgieProposalDetailProvider = FutureProvider.family<LedgieProposal, String>((ref, id) async {
  return ref.watch(ledgieProposalRepositoryProvider).getById(id);
});
