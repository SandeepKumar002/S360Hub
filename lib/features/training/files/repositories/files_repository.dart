import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/file_model.dart';

class TrainingFileRepository {
  final SupabaseClient _client;

  TrainingFileRepository(this._client);

  Future<List<TrainingFile>> getAll() async {
    final response = await _client
        .from('training.files')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingFile.fromJson(e)).toList();
  }

  Future<TrainingFile> getById(String id) async {
    final response = await _client
        .from('training.files')
        .select()
        .eq('id', id)
        .single();
    return TrainingFile.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.files').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.files').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.files').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingFileRepositoryProvider = Provider<TrainingFileRepository>((ref) {
  return TrainingFileRepository(Supabase.instance.client);
});

final trainingFileListProvider = FutureProvider<List<TrainingFile>>((ref) async {
  return ref.watch(trainingFileRepositoryProvider).getAll();
});

final trainingFileDetailProvider = FutureProvider.family<TrainingFile, String>((ref, id) async {
  return ref.watch(trainingFileRepositoryProvider).getById(id);
});
