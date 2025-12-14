import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/file_model.dart';

class ContracforceFileRepository {
  final SupabaseClient _client;

  ContracforceFileRepository(this._client);

  Future<List<ContracforceFile>> getAll() async {
    final response = await _client
        .from('contracforce.files')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ContracforceFile.fromJson(e)).toList();
  }

  Future<ContracforceFile> getById(String id) async {
    final response = await _client
        .from('contracforce.files')
        .select()
        .eq('id', id)
        .single();
    return ContracforceFile.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('contracforce.files').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('contracforce.files').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('contracforce.files').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final contracforceFileRepositoryProvider = Provider<ContracforceFileRepository>((ref) {
  return ContracforceFileRepository(Supabase.instance.client);
});

final contracforceFileListProvider = FutureProvider<List<ContracforceFile>>((ref) async {
  return ref.watch(contracforceFileRepositoryProvider).getAll();
});

final contracforceFileDetailProvider = FutureProvider.family<ContracforceFile, String>((ref, id) async {
  return ref.watch(contracforceFileRepositoryProvider).getById(id);
});
