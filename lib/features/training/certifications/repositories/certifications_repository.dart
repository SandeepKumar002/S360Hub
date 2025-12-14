import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/certification_model.dart';

class TrainingCertificationRepository {
  final SupabaseClient _client;

  TrainingCertificationRepository(this._client);

  Future<List<TrainingCertification>> getAll() async {
    final response = await _client
        .from('training.certifications')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingCertification.fromJson(e)).toList();
  }

  Future<TrainingCertification> getById(String id) async {
    final response = await _client
        .from('training.certifications')
        .select()
        .eq('id', id)
        .single();
    return TrainingCertification.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.certifications').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.certifications').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.certifications').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingCertificationRepositoryProvider = Provider<TrainingCertificationRepository>((ref) {
  return TrainingCertificationRepository(Supabase.instance.client);
});

final trainingCertificationListProvider = FutureProvider<List<TrainingCertification>>((ref) async {
  return ref.watch(trainingCertificationRepositoryProvider).getAll();
});

final trainingCertificationDetailProvider = FutureProvider.family<TrainingCertification, String>((ref, id) async {
  return ref.watch(trainingCertificationRepositoryProvider).getById(id);
});
