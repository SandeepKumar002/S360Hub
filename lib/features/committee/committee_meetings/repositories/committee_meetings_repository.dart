import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/committee_meeting_model.dart';

class CommitteeCommitteeMeetingRepository {
  final SupabaseClient _client;

  CommitteeCommitteeMeetingRepository(this._client);

  Future<List<CommitteeCommitteeMeeting>> getAll() async {
    final response = await _client
        .from('committee.committee_meetings')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommitteeCommitteeMeeting.fromJson(e)).toList();
  }

  Future<CommitteeCommitteeMeeting> getById(String id) async {
    final response = await _client
        .from('committee.committee_meetings')
        .select()
        .eq('id', id)
        .single();
    return CommitteeCommitteeMeeting.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('committee.committee_meetings').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('committee.committee_meetings').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('committee.committee_meetings').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final committeeCommitteeMeetingRepositoryProvider = Provider<CommitteeCommitteeMeetingRepository>((ref) {
  return CommitteeCommitteeMeetingRepository(Supabase.instance.client);
});

final committeeCommitteeMeetingListProvider = FutureProvider<List<CommitteeCommitteeMeeting>>((ref) async {
  return ref.watch(committeeCommitteeMeetingRepositoryProvider).getAll();
});

final committeeCommitteeMeetingDetailProvider = FutureProvider.family<CommitteeCommitteeMeeting, String>((ref, id) async {
  return ref.watch(committeeCommitteeMeetingRepositoryProvider).getById(id);
});
