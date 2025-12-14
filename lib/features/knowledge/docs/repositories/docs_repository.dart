import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/doc_model.dart';

class KnowledgeDocRepository {
  final SupabaseClient _client;

  KnowledgeDocRepository(this._client);

  Future<List<KnowledgeDoc>> getAll() async {
    final response = await _client
        .from('knowledge.docs')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => KnowledgeDoc.fromJson(e)).toList();
  }

  Future<KnowledgeDoc> getById(String id) async {
    final response = await _client
        .from('knowledge.docs')
        .select()
        .eq('id', id)
        .single();
    return KnowledgeDoc.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('knowledge.docs').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('knowledge.docs').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('knowledge.docs').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final knowledgeDocRepositoryProvider = Provider<KnowledgeDocRepository>((ref) {
  return KnowledgeDocRepository(Supabase.instance.client);
});

final knowledgeDocListProvider = FutureProvider<List<KnowledgeDoc>>((ref) async {
  return ref.watch(knowledgeDocRepositoryProvider).getAll();
});

final knowledgeDocDetailProvider = FutureProvider.family<KnowledgeDoc, String>((ref, id) async {
  return ref.watch(knowledgeDocRepositoryProvider).getById(id);
});
