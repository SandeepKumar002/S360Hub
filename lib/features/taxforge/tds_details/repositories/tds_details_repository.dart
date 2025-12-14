import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tds_detail_model.dart';

class TaxforgeTdsDetailRepository {
  final SupabaseClient _client;

  TaxforgeTdsDetailRepository(this._client);

  Future<List<TaxforgeTdsDetail>> getAll() async {
    final response = await _client
        .from('taxforge.tds_details')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TaxforgeTdsDetail.fromJson(e)).toList();
  }

  Future<TaxforgeTdsDetail> getById(String id) async {
    final response = await _client
        .from('taxforge.tds_details')
        .select()
        .eq('id', id)
        .single();
    return TaxforgeTdsDetail.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('taxforge.tds_details').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('taxforge.tds_details').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('taxforge.tds_details').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final taxforgeTdsDetailRepositoryProvider = Provider<TaxforgeTdsDetailRepository>((ref) {
  return TaxforgeTdsDetailRepository(Supabase.instance.client);
});

final taxforgeTdsDetailListProvider = FutureProvider<List<TaxforgeTdsDetail>>((ref) async {
  return ref.watch(taxforgeTdsDetailRepositoryProvider).getAll();
});

final taxforgeTdsDetailDetailProvider = FutureProvider.family<TaxforgeTdsDetail, String>((ref, id) async {
  return ref.watch(taxforgeTdsDetailRepositoryProvider).getById(id);
});
