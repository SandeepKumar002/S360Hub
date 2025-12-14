import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/doc_tag_model.dart';

class KnowledgeDocTagRepository {
  final SupabaseClient _client;

  KnowledgeDocTagRepository(this._client);

  Future<List<KnowledgeDocTag>> getAll() async {
    final response = await _client
        .from('knowledge.doc_tags')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => KnowledgeDocTag.fromJson(e)).toList();
  }

  Future<KnowledgeDocTag> getById(String id) async {
    final response = await _client
        .from('knowledge.doc_tags')
        .select()
        .eq('id', id)
        .single();
    return KnowledgeDocTag.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('knowledge.doc_tags').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('knowledge.doc_tags').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('knowledge.doc_tags').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final knowledgeDocTagRepositoryProvider = Provider<KnowledgeDocTagRepository>((ref) {
  return KnowledgeDocTagRepository(Supabase.instance.client);
});

final knowledgeDocTagListProvider = FutureProvider<List<KnowledgeDocTag>>((ref) async {
  return ref.watch(knowledgeDocTagRepositoryProvider).getAll();
});

final knowledgeDocTagDetailProvider = FutureProvider.family<KnowledgeDocTag, String>((ref, id) async {
  return ref.watch(knowledgeDocTagRepositoryProvider).getById(id);
});
