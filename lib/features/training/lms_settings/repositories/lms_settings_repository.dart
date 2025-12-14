import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/lms_setting_model.dart';

class TrainingLmsSettingRepository {
  final SupabaseClient _client;

  TrainingLmsSettingRepository(this._client);

  Future<List<TrainingLmsSetting>> getAll() async {
    final response = await _client
        .from('training.lms_settings')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingLmsSetting.fromJson(e)).toList();
  }

  Future<TrainingLmsSetting> getById(String id) async {
    final response = await _client
        .from('training.lms_settings')
        .select()
        .eq('id', id)
        .single();
    return TrainingLmsSetting.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.lms_settings').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.lms_settings').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.lms_settings').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingLmsSettingRepositoryProvider = Provider<TrainingLmsSettingRepository>((ref) {
  return TrainingLmsSettingRepository(Supabase.instance.client);
});

final trainingLmsSettingListProvider = FutureProvider<List<TrainingLmsSetting>>((ref) async {
  return ref.watch(trainingLmsSettingRepositoryProvider).getAll();
});

final trainingLmsSettingDetailProvider = FutureProvider.family<TrainingLmsSetting, String>((ref, id) async {
  return ref.watch(trainingLmsSettingRepositoryProvider).getById(id);
});
