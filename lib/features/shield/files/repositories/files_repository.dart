import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/file_model.dart';

class ShieldFileRepository {
  final SupabaseClient _client;

  ShieldFileRepository(this._client);

  Future<List<ShieldFile>> getAll() async {
    final response = await _client
        .from('shield.files')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ShieldFile.fromJson(e)).toList();
  }

  Future<ShieldFile> getById(String id) async {
    final response = await _client
        .from('shield.files')
        .select()
        .eq('id', id)
        .single();
    return ShieldFile.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('shield.files').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('shield.files').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('shield.files').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final shieldFileRepositoryProvider = Provider<ShieldFileRepository>((ref) {
  return ShieldFileRepository(Supabase.instance.client);
});

final shieldFileListProvider = FutureProvider<List<ShieldFile>>((ref) async {
  return ref.watch(shieldFileRepositoryProvider).getAll();
});

final shieldFileDetailProvider = FutureProvider.family<ShieldFile, String>((ref, id) async {
  return ref.watch(shieldFileRepositoryProvider).getById(id);
});
