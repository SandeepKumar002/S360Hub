import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/session_model.dart';

class TrainingSessionRepository {
  final SupabaseClient _client;

  TrainingSessionRepository(this._client);

  Future<List<TrainingSession>> getAll() async {
    final response = await _client
        .from('training.sessions')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingSession.fromJson(e)).toList();
  }

  Future<TrainingSession> getById(String id) async {
    final response = await _client
        .from('training.sessions')
        .select()
        .eq('id', id)
        .single();
    return TrainingSession.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.sessions').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.sessions').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.sessions').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingSessionRepositoryProvider = Provider<TrainingSessionRepository>((ref) {
  return TrainingSessionRepository(Supabase.instance.client);
});

final trainingSessionListProvider = FutureProvider<List<TrainingSession>>((ref) async {
  return ref.watch(trainingSessionRepositoryProvider).getAll();
});

final trainingSessionDetailProvider = FutureProvider.family<TrainingSession, String>((ref, id) async {
  return ref.watch(trainingSessionRepositoryProvider).getById(id);
});
