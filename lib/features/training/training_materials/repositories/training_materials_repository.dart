import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/training_material_model.dart';

class TrainingTrainingMaterialRepository {
  final SupabaseClient _client;

  TrainingTrainingMaterialRepository(this._client);

  Future<List<TrainingTrainingMaterial>> getAll() async {
    final response = await _client
        .from('training.training_materials')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingTrainingMaterial.fromJson(e)).toList();
  }

  Future<TrainingTrainingMaterial> getById(String id) async {
    final response = await _client
        .from('training.training_materials')
        .select()
        .eq('id', id)
        .single();
    return TrainingTrainingMaterial.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.training_materials').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.training_materials').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.training_materials').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingTrainingMaterialRepositoryProvider = Provider<TrainingTrainingMaterialRepository>((ref) {
  return TrainingTrainingMaterialRepository(Supabase.instance.client);
});

final trainingTrainingMaterialListProvider = FutureProvider<List<TrainingTrainingMaterial>>((ref) async {
  return ref.watch(trainingTrainingMaterialRepositoryProvider).getAll();
});

final trainingTrainingMaterialDetailProvider = FutureProvider.family<TrainingTrainingMaterial, String>((ref, id) async {
  return ref.watch(trainingTrainingMaterialRepositoryProvider).getById(id);
});
