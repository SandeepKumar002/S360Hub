import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/agreement_model.dart';

class LedgieAgreementRepository {
  final SupabaseClient _client;

  LedgieAgreementRepository(this._client);

  Future<List<LedgieAgreement>> getAll() async {
    final response = await _client
        .from('ledgie.agreements')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieAgreement.fromJson(e)).toList();
  }

  Future<LedgieAgreement> getById(String id) async {
    final response = await _client
        .from('ledgie.agreements')
        .select()
        .eq('id', id)
        .single();
    return LedgieAgreement.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.agreements').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.agreements').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.agreements').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieAgreementRepositoryProvider = Provider<LedgieAgreementRepository>((ref) {
  return LedgieAgreementRepository(Supabase.instance.client);
});

final ledgieAgreementListProvider = FutureProvider<List<LedgieAgreement>>((ref) async {
  return ref.watch(ledgieAgreementRepositoryProvider).getAll();
});

final ledgieAgreementDetailProvider = FutureProvider.family<LedgieAgreement, String>((ref, id) async {
  return ref.watch(ledgieAgreementRepositoryProvider).getById(id);
});
