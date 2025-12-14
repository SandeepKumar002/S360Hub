import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/doc_tag_map_model.dart';

class KnowledgeDocTagMapRepository {
  final SupabaseClient _client;

  KnowledgeDocTagMapRepository(this._client);

  Future<List<KnowledgeDocTagMap>> getAll() async {
    final response = await _client
        .from('knowledge.doc_tag_map')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => KnowledgeDocTagMap.fromJson(e)).toList();
  }

  Future<KnowledgeDocTagMap> getById(String id) async {
    final response = await _client
        .from('knowledge.doc_tag_map')
        .select()
        .eq('id', id)
        .single();
    return KnowledgeDocTagMap.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('knowledge.doc_tag_map').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('knowledge.doc_tag_map').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('knowledge.doc_tag_map').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final knowledgeDocTagMapRepositoryProvider = Provider<KnowledgeDocTagMapRepository>((ref) {
  return KnowledgeDocTagMapRepository(Supabase.instance.client);
});

final knowledgeDocTagMapListProvider = FutureProvider<List<KnowledgeDocTagMap>>((ref) async {
  return ref.watch(knowledgeDocTagMapRepositoryProvider).getAll();
});

final knowledgeDocTagMapDetailProvider = FutureProvider.family<KnowledgeDocTagMap, String>((ref, id) async {
  return ref.watch(knowledgeDocTagMapRepositoryProvider).getById(id);
});
