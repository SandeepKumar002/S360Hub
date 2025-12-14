import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/file_model.dart';

class FinacFileRepository {
  final SupabaseClient _client;

  FinacFileRepository(this._client);

  Future<List<FinacFile>> getAll() async {
    final response = await _client
        .from('finac.files')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacFile.fromJson(e)).toList();
  }

  Future<FinacFile> getById(String id) async {
    final response = await _client
        .from('finac.files')
        .select()
        .eq('id', id)
        .single();
    return FinacFile.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.files').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.files').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.files').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacFileRepositoryProvider = Provider<FinacFileRepository>((ref) {
  return FinacFileRepository(Supabase.instance.client);
});

final finacFileListProvider = FutureProvider<List<FinacFile>>((ref) async {
  return ref.watch(finacFileRepositoryProvider).getAll();
});

final finacFileDetailProvider = FutureProvider.family<FinacFile, String>((ref, id) async {
  return ref.watch(finacFileRepositoryProvider).getById(id);
});
