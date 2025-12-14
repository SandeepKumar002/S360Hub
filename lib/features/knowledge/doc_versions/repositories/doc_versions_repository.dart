import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/doc_version_model.dart';

class KnowledgeDocVersionRepository {
  final SupabaseClient _client;

  KnowledgeDocVersionRepository(this._client);

  Future<List<KnowledgeDocVersion>> getAll() async {
    final response = await _client
        .from('knowledge.doc_versions')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => KnowledgeDocVersion.fromJson(e)).toList();
  }

  Future<KnowledgeDocVersion> getById(String id) async {
    final response = await _client
        .from('knowledge.doc_versions')
        .select()
        .eq('id', id)
        .single();
    return KnowledgeDocVersion.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('knowledge.doc_versions').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('knowledge.doc_versions').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('knowledge.doc_versions').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final knowledgeDocVersionRepositoryProvider = Provider<KnowledgeDocVersionRepository>((ref) {
  return KnowledgeDocVersionRepository(Supabase.instance.client);
});

final knowledgeDocVersionListProvider = FutureProvider<List<KnowledgeDocVersion>>((ref) async {
  return ref.watch(knowledgeDocVersionRepositoryProvider).getAll();
});

final knowledgeDocVersionDetailProvider = FutureProvider.family<KnowledgeDocVersion, String>((ref, id) async {
  return ref.watch(knowledgeDocVersionRepositoryProvider).getById(id);
});
