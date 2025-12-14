import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/contractor_staff_document_model.dart';

class ContracforceContractorStaffDocumentRepository {
  final SupabaseClient _client;

  ContracforceContractorStaffDocumentRepository(this._client);

  Future<List<ContracforceContractorStaffDocument>> getAll() async {
    final response = await _client
        .from('contracforce.contractor_staff_documents')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ContracforceContractorStaffDocument.fromJson(e)).toList();
  }

  Future<ContracforceContractorStaffDocument> getById(String id) async {
    final response = await _client
        .from('contracforce.contractor_staff_documents')
        .select()
        .eq('id', id)
        .single();
    return ContracforceContractorStaffDocument.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('contracforce.contractor_staff_documents').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('contracforce.contractor_staff_documents').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('contracforce.contractor_staff_documents').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final contracforceContractorStaffDocumentRepositoryProvider = Provider<ContracforceContractorStaffDocumentRepository>((ref) {
  return ContracforceContractorStaffDocumentRepository(Supabase.instance.client);
});

final contracforceContractorStaffDocumentListProvider = FutureProvider<List<ContracforceContractorStaffDocument>>((ref) async {
  return ref.watch(contracforceContractorStaffDocumentRepositoryProvider).getAll();
});

final contracforceContractorStaffDocumentDetailProvider = FutureProvider.family<ContracforceContractorStaffDocument, String>((ref, id) async {
  return ref.watch(contracforceContractorStaffDocumentRepositoryProvider).getById(id);
});
