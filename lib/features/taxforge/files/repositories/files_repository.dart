import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/file_model.dart';

class TaxforgeFileRepository {
  final SupabaseClient _client;

  TaxforgeFileRepository(this._client);

  Future<List<TaxforgeFile>> getAll() async {
    final response = await _client
        .from('taxforge.files')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TaxforgeFile.fromJson(e)).toList();
  }

  Future<TaxforgeFile> getById(String id) async {
    final response = await _client
        .from('taxforge.files')
        .select()
        .eq('id', id)
        .single();
    return TaxforgeFile.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('taxforge.files').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('taxforge.files').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('taxforge.files').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final taxforgeFileRepositoryProvider = Provider<TaxforgeFileRepository>((ref) {
  return TaxforgeFileRepository(Supabase.instance.client);
});

final taxforgeFileListProvider = FutureProvider<List<TaxforgeFile>>((ref) async {
  return ref.watch(taxforgeFileRepositoryProvider).getAll();
});

final taxforgeFileDetailProvider = FutureProvider.family<TaxforgeFile, String>((ref, id) async {
  return ref.watch(taxforgeFileRepositoryProvider).getById(id);
});
