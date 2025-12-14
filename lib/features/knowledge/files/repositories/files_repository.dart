import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/file_model.dart';

class KnowledgeFileRepository {
  final SupabaseClient _client;

  KnowledgeFileRepository(this._client);

  Future<List<KnowledgeFile>> getAll() async {
    final response = await _client
        .from('knowledge.files')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => KnowledgeFile.fromJson(e)).toList();
  }

  Future<KnowledgeFile> getById(String id) async {
    final response = await _client
        .from('knowledge.files')
        .select()
        .eq('id', id)
        .single();
    return KnowledgeFile.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('knowledge.files').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('knowledge.files').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('knowledge.files').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final knowledgeFileRepositoryProvider = Provider<KnowledgeFileRepository>((ref) {
  return KnowledgeFileRepository(Supabase.instance.client);
});

final knowledgeFileListProvider = FutureProvider<List<KnowledgeFile>>((ref) async {
  return ref.watch(knowledgeFileRepositoryProvider).getAll();
});

final knowledgeFileDetailProvider = FutureProvider.family<KnowledgeFile, String>((ref, id) async {
  return ref.watch(knowledgeFileRepositoryProvider).getById(id);
});
