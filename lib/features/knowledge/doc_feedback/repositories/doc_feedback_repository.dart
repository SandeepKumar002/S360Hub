import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/doc_feedback_model.dart';

class KnowledgeDocFeedbackRepository {
  final SupabaseClient _client;

  KnowledgeDocFeedbackRepository(this._client);

  Future<List<KnowledgeDocFeedback>> getAll() async {
    final response = await _client
        .from('knowledge.doc_feedback')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => KnowledgeDocFeedback.fromJson(e)).toList();
  }

  Future<KnowledgeDocFeedback> getById(String id) async {
    final response = await _client
        .from('knowledge.doc_feedback')
        .select()
        .eq('id', id)
        .single();
    return KnowledgeDocFeedback.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('knowledge.doc_feedback').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('knowledge.doc_feedback').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('knowledge.doc_feedback').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final knowledgeDocFeedbackRepositoryProvider = Provider<KnowledgeDocFeedbackRepository>((ref) {
  return KnowledgeDocFeedbackRepository(Supabase.instance.client);
});

final knowledgeDocFeedbackListProvider = FutureProvider<List<KnowledgeDocFeedback>>((ref) async {
  return ref.watch(knowledgeDocFeedbackRepositoryProvider).getAll();
});

final knowledgeDocFeedbackDetailProvider = FutureProvider.family<KnowledgeDocFeedback, String>((ref, id) async {
  return ref.watch(knowledgeDocFeedbackRepositoryProvider).getById(id);
});
