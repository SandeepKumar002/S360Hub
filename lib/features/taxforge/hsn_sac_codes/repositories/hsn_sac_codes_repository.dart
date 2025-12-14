import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/hsn_sac_code_model.dart';

class TaxforgeHsnSacCodeRepository {
  final SupabaseClient _client;

  TaxforgeHsnSacCodeRepository(this._client);

  Future<List<TaxforgeHsnSacCode>> getAll() async {
    final response = await _client
        .from('taxforge.hsn_sac_codes')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TaxforgeHsnSacCode.fromJson(e)).toList();
  }

  Future<TaxforgeHsnSacCode> getById(String id) async {
    final response = await _client
        .from('taxforge.hsn_sac_codes')
        .select()
        .eq('id', id)
        .single();
    return TaxforgeHsnSacCode.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('taxforge.hsn_sac_codes').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('taxforge.hsn_sac_codes').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('taxforge.hsn_sac_codes').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final taxforgeHsnSacCodeRepositoryProvider = Provider<TaxforgeHsnSacCodeRepository>((ref) {
  return TaxforgeHsnSacCodeRepository(Supabase.instance.client);
});

final taxforgeHsnSacCodeListProvider = FutureProvider<List<TaxforgeHsnSacCode>>((ref) async {
  return ref.watch(taxforgeHsnSacCodeRepositoryProvider).getAll();
});

final taxforgeHsnSacCodeDetailProvider = FutureProvider.family<TaxforgeHsnSacCode, String>((ref, id) async {
  return ref.watch(taxforgeHsnSacCodeRepositoryProvider).getById(id);
});
