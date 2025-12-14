import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/committee_member_model.dart';

class CommitteeCommitteeMemberRepository {
  final SupabaseClient _client;

  CommitteeCommitteeMemberRepository(this._client);

  Future<List<CommitteeCommitteeMember>> getAll() async {
    final response = await _client
        .from('committee.committee_members')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommitteeCommitteeMember.fromJson(e)).toList();
  }

  Future<CommitteeCommitteeMember> getById(String id) async {
    final response = await _client
        .from('committee.committee_members')
        .select()
        .eq('id', id)
        .single();
    return CommitteeCommitteeMember.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('committee.committee_members').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('committee.committee_members').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('committee.committee_members').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final committeeCommitteeMemberRepositoryProvider = Provider<CommitteeCommitteeMemberRepository>((ref) {
  return CommitteeCommitteeMemberRepository(Supabase.instance.client);
});

final committeeCommitteeMemberListProvider = FutureProvider<List<CommitteeCommitteeMember>>((ref) async {
  return ref.watch(committeeCommitteeMemberRepositoryProvider).getAll();
});

final committeeCommitteeMemberDetailProvider = FutureProvider.family<CommitteeCommitteeMember, String>((ref, id) async {
  return ref.watch(committeeCommitteeMemberRepositoryProvider).getById(id);
});
