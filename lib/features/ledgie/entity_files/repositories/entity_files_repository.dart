import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/entity_file_model.dart';

class LedgieEntityFileRepository {
  final SupabaseClient _client;

  LedgieEntityFileRepository(this._client);

  Future<List<LedgieEntityFile>> getAll() async {
    final response = await _client
        .from('ledgie.entity_files')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieEntityFile.fromJson(e)).toList();
  }

  Future<LedgieEntityFile> getById(String id) async {
    final response = await _client
        .from('ledgie.entity_files')
        .select()
        .eq('id', id)
        .single();
    return LedgieEntityFile.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.entity_files').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.entity_files').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.entity_files').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieEntityFileRepositoryProvider = Provider<LedgieEntityFileRepository>((ref) {
  return LedgieEntityFileRepository(Supabase.instance.client);
});

final ledgieEntityFileListProvider = FutureProvider<List<LedgieEntityFile>>((ref) async {
  return ref.watch(ledgieEntityFileRepositoryProvider).getAll();
});

final ledgieEntityFileDetailProvider = FutureProvider.family<LedgieEntityFile, String>((ref, id) async {
  return ref.watch(ledgieEntityFileRepositoryProvider).getById(id);
});
