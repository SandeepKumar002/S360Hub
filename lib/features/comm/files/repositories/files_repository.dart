import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/file_model.dart';

class CommFileRepository {
  final SupabaseClient _client;

  CommFileRepository(this._client);

  Future<List<CommFile>> getAll() async {
    final response = await _client
        .from('comm.files')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommFile.fromJson(e)).toList();
  }

  Future<CommFile> getById(String id) async {
    final response = await _client
        .from('comm.files')
        .select()
        .eq('id', id)
        .single();
    return CommFile.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('comm.files').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('comm.files').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('comm.files').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final commFileRepositoryProvider = Provider<CommFileRepository>((ref) {
  return CommFileRepository(Supabase.instance.client);
});

final commFileListProvider = FutureProvider<List<CommFile>>((ref) async {
  return ref.watch(commFileRepositoryProvider).getAll();
});

final commFileDetailProvider = FutureProvider.family<CommFile, String>((ref, id) async {
  return ref.watch(commFileRepositoryProvider).getById(id);
});
