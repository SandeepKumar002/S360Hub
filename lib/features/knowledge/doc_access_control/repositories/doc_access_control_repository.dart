import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/doc_access_control_model.dart';

class KnowledgeDocAccessControlRepository {
  final SupabaseClient _client;

  KnowledgeDocAccessControlRepository(this._client);

  Future<List<KnowledgeDocAccessControl>> getAll() async {
    final response = await _client
        .from('knowledge.doc_access_control')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => KnowledgeDocAccessControl.fromJson(e)).toList();
  }

  Future<KnowledgeDocAccessControl> getById(String id) async {
    final response = await _client
        .from('knowledge.doc_access_control')
        .select()
        .eq('id', id)
        .single();
    return KnowledgeDocAccessControl.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('knowledge.doc_access_control').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('knowledge.doc_access_control').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('knowledge.doc_access_control').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final knowledgeDocAccessControlRepositoryProvider = Provider<KnowledgeDocAccessControlRepository>((ref) {
  return KnowledgeDocAccessControlRepository(Supabase.instance.client);
});

final knowledgeDocAccessControlListProvider = FutureProvider<List<KnowledgeDocAccessControl>>((ref) async {
  return ref.watch(knowledgeDocAccessControlRepositoryProvider).getAll();
});

final knowledgeDocAccessControlDetailProvider = FutureProvider.family<KnowledgeDocAccessControl, String>((ref, id) async {
  return ref.watch(knowledgeDocAccessControlRepositoryProvider).getById(id);
});
