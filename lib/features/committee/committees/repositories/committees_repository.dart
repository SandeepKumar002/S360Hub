import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/committee_model.dart';

class CommitteeCommitteeRepository {
  final SupabaseClient _client;

  CommitteeCommitteeRepository(this._client);

  Future<List<CommitteeCommittee>> getAll() async {
    final response = await _client
        .from('committee.committees')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommitteeCommittee.fromJson(e)).toList();
  }

  Future<CommitteeCommittee> getById(String id) async {
    final response = await _client
        .from('committee.committees')
        .select()
        .eq('id', id)
        .single();
    return CommitteeCommittee.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('committee.committees').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('committee.committees').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('committee.committees').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final committeeCommitteeRepositoryProvider = Provider<CommitteeCommitteeRepository>((ref) {
  return CommitteeCommitteeRepository(Supabase.instance.client);
});

final committeeCommitteeListProvider = FutureProvider<List<CommitteeCommittee>>((ref) async {
  return ref.watch(committeeCommitteeRepositoryProvider).getAll();
});

final committeeCommitteeDetailProvider = FutureProvider.family<CommitteeCommittee, String>((ref, id) async {
  return ref.watch(committeeCommitteeRepositoryProvider).getById(id);
});
