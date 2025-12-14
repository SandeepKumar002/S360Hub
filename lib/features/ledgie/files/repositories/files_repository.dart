import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/file_model.dart';

class LedgieFileRepository {
  final SupabaseClient _client;

  LedgieFileRepository(this._client);

  Future<List<LedgieFile>> getAll() async {
    final response = await _client
        .from('ledgie.files')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieFile.fromJson(e)).toList();
  }

  Future<LedgieFile> getById(String id) async {
    final response = await _client
        .from('ledgie.files')
        .select()
        .eq('id', id)
        .single();
    return LedgieFile.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.files').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.files').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.files').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieFileRepositoryProvider = Provider<LedgieFileRepository>((ref) {
  return LedgieFileRepository(Supabase.instance.client);
});

final ledgieFileListProvider = FutureProvider<List<LedgieFile>>((ref) async {
  return ref.watch(ledgieFileRepositoryProvider).getAll();
});

final ledgieFileDetailProvider = FutureProvider.family<LedgieFile, String>((ref, id) async {
  return ref.watch(ledgieFileRepositoryProvider).getById(id);
});
