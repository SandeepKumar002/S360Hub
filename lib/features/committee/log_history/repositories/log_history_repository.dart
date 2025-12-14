import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/log_history_model.dart';

class CommitteeLogHistoryRepository {
  final SupabaseClient _client;

  CommitteeLogHistoryRepository(this._client);

  Future<List<CommitteeLogHistory>> getAll() async {
    final response = await _client
        .from('committee.log_history')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommitteeLogHistory.fromJson(e)).toList();
  }

  Future<CommitteeLogHistory> getById(String id) async {
    final response = await _client
        .from('committee.log_history')
        .select()
        .eq('id', id)
        .single();
    return CommitteeLogHistory.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('committee.log_history').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('committee.log_history').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('committee.log_history').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final committeeLogHistoryRepositoryProvider = Provider<CommitteeLogHistoryRepository>((ref) {
  return CommitteeLogHistoryRepository(Supabase.instance.client);
});

final committeeLogHistoryListProvider = FutureProvider<List<CommitteeLogHistory>>((ref) async {
  return ref.watch(committeeLogHistoryRepositoryProvider).getAll();
});

final committeeLogHistoryDetailProvider = FutureProvider.family<CommitteeLogHistory, String>((ref, id) async {
  return ref.watch(committeeLogHistoryRepositoryProvider).getById(id);
});
