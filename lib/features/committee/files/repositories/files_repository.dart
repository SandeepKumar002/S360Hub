import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/file_model.dart';

class CommitteeFileRepository {
  final SupabaseClient _client;

  CommitteeFileRepository(this._client);

  Future<List<CommitteeFile>> getAll() async {
    final response = await _client
        .from('committee.files')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommitteeFile.fromJson(e)).toList();
  }

  Future<CommitteeFile> getById(String id) async {
    final response = await _client
        .from('committee.files')
        .select()
        .eq('id', id)
        .single();
    return CommitteeFile.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('committee.files').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('committee.files').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('committee.files').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final committeeFileRepositoryProvider = Provider<CommitteeFileRepository>((ref) {
  return CommitteeFileRepository(Supabase.instance.client);
});

final committeeFileListProvider = FutureProvider<List<CommitteeFile>>((ref) async {
  return ref.watch(committeeFileRepositoryProvider).getAll();
});

final committeeFileDetailProvider = FutureProvider.family<CommitteeFile, String>((ref, id) async {
  return ref.watch(committeeFileRepositoryProvider).getById(id);
});
