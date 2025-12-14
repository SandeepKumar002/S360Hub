import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/contractor_compliance_document_model.dart';

class ContracforceContractorComplianceDocumentRepository {
  final SupabaseClient _client;

  ContracforceContractorComplianceDocumentRepository(this._client);

  Future<List<ContracforceContractorComplianceDocument>> getAll() async {
    final response = await _client
        .from('contracforce.contractor_compliance_documents')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ContracforceContractorComplianceDocument.fromJson(e)).toList();
  }

  Future<ContracforceContractorComplianceDocument> getById(String id) async {
    final response = await _client
        .from('contracforce.contractor_compliance_documents')
        .select()
        .eq('id', id)
        .single();
    return ContracforceContractorComplianceDocument.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('contracforce.contractor_compliance_documents').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('contracforce.contractor_compliance_documents').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('contracforce.contractor_compliance_documents').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final contracforceContractorComplianceDocumentRepositoryProvider = Provider<ContracforceContractorComplianceDocumentRepository>((ref) {
  return ContracforceContractorComplianceDocumentRepository(Supabase.instance.client);
});

final contracforceContractorComplianceDocumentListProvider = FutureProvider<List<ContracforceContractorComplianceDocument>>((ref) async {
  return ref.watch(contracforceContractorComplianceDocumentRepositoryProvider).getAll();
});

final contracforceContractorComplianceDocumentDetailProvider = FutureProvider.family<ContracforceContractorComplianceDocument, String>((ref, id) async {
  return ref.watch(contracforceContractorComplianceDocumentRepositoryProvider).getById(id);
});
