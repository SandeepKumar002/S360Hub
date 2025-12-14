import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/log_history_model.dart';

class TrainingLogHistoryRepository {
  final SupabaseClient _client;

  TrainingLogHistoryRepository(this._client);

  Future<List<TrainingLogHistory>> getAll() async {
    final response = await _client
        .from('training.log_history')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingLogHistory.fromJson(e)).toList();
  }

  Future<TrainingLogHistory> getById(String id) async {
    final response = await _client
        .from('training.log_history')
        .select()
        .eq('id', id)
        .single();
    return TrainingLogHistory.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.log_history').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.log_history').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.log_history').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingLogHistoryRepositoryProvider = Provider<TrainingLogHistoryRepository>((ref) {
  return TrainingLogHistoryRepository(Supabase.instance.client);
});

final trainingLogHistoryListProvider = FutureProvider<List<TrainingLogHistory>>((ref) async {
  return ref.watch(trainingLogHistoryRepositoryProvider).getAll();
});

final trainingLogHistoryDetailProvider = FutureProvider.family<TrainingLogHistory, String>((ref, id) async {
  return ref.watch(trainingLogHistoryRepositoryProvider).getById(id);
});
