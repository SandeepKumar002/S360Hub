import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course_model.dart';

class TrainingCourseRepository {
  final SupabaseClient _client;

  TrainingCourseRepository(this._client);

  Future<List<TrainingCourse>> getAll() async {
    final response = await _client
        .from('training.courses')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingCourse.fromJson(e)).toList();
  }

  Future<TrainingCourse> getById(String id) async {
    final response = await _client
        .from('training.courses')
        .select()
        .eq('id', id)
        .single();
    return TrainingCourse.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.courses').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.courses').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.courses').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingCourseRepositoryProvider = Provider<TrainingCourseRepository>((ref) {
  return TrainingCourseRepository(Supabase.instance.client);
});

final trainingCourseListProvider = FutureProvider<List<TrainingCourse>>((ref) async {
  return ref.watch(trainingCourseRepositoryProvider).getAll();
});

final trainingCourseDetailProvider = FutureProvider.family<TrainingCourse, String>((ref, id) async {
  return ref.watch(trainingCourseRepositoryProvider).getById(id);
});
