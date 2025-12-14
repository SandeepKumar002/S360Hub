import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/gst_detail_model.dart';

class TaxforgeGstDetailRepository {
  final SupabaseClient _client;

  TaxforgeGstDetailRepository(this._client);

  Future<List<TaxforgeGstDetail>> getAll() async {
    final response = await _client
        .from('taxforge.gst_details')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TaxforgeGstDetail.fromJson(e)).toList();
  }

  Future<TaxforgeGstDetail> getById(String id) async {
    final response = await _client
        .from('taxforge.gst_details')
        .select()
        .eq('id', id)
        .single();
    return TaxforgeGstDetail.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('taxforge.gst_details').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('taxforge.gst_details').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('taxforge.gst_details').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final taxforgeGstDetailRepositoryProvider = Provider<TaxforgeGstDetailRepository>((ref) {
  return TaxforgeGstDetailRepository(Supabase.instance.client);
});

final taxforgeGstDetailListProvider = FutureProvider<List<TaxforgeGstDetail>>((ref) async {
  return ref.watch(taxforgeGstDetailRepositoryProvider).getAll();
});

final taxforgeGstDetailDetailProvider = FutureProvider.family<TaxforgeGstDetail, String>((ref, id) async {
  return ref.watch(taxforgeGstDetailRepositoryProvider).getById(id);
});
