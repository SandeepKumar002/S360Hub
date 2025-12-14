import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/committee_meeting_record_model.dart';

class CommitteeCommitteeMeetingRecordRepository {
  final SupabaseClient _client;

  CommitteeCommitteeMeetingRecordRepository(this._client);

  Future<List<CommitteeCommitteeMeetingRecord>> getAll() async {
    final response = await _client
        .from('committee.committee_meeting_records')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommitteeCommitteeMeetingRecord.fromJson(e)).toList();
  }

  Future<CommitteeCommitteeMeetingRecord> getById(String id) async {
    final response = await _client
        .from('committee.committee_meeting_records')
        .select()
        .eq('id', id)
        .single();
    return CommitteeCommitteeMeetingRecord.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('committee.committee_meeting_records').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('committee.committee_meeting_records').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('committee.committee_meeting_records').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final committeeCommitteeMeetingRecordRepositoryProvider = Provider<CommitteeCommitteeMeetingRecordRepository>((ref) {
  return CommitteeCommitteeMeetingRecordRepository(Supabase.instance.client);
});

final committeeCommitteeMeetingRecordListProvider = FutureProvider<List<CommitteeCommitteeMeetingRecord>>((ref) async {
  return ref.watch(committeeCommitteeMeetingRecordRepositoryProvider).getAll();
});

final committeeCommitteeMeetingRecordDetailProvider = FutureProvider.family<CommitteeCommitteeMeetingRecord, String>((ref, id) async {
  return ref.watch(committeeCommitteeMeetingRecordRepositoryProvider).getById(id);
});
