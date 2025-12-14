import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course_unit_model.dart';

class TrainingCourseUnitRepository {
  final SupabaseClient _client;

  TrainingCourseUnitRepository(this._client);

  Future<List<TrainingCourseUnit>> getAll() async {
    final response = await _client
        .from('training.course_units')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => TrainingCourseUnit.fromJson(e)).toList();
  }

  Future<TrainingCourseUnit> getById(String id) async {
    final response = await _client
        .from('training.course_units')
        .select()
        .eq('id', id)
        .single();
    return TrainingCourseUnit.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('training.course_units').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('training.course_units').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('training.course_units').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final trainingCourseUnitRepositoryProvider = Provider<TrainingCourseUnitRepository>((ref) {
  return TrainingCourseUnitRepository(Supabase.instance.client);
});

final trainingCourseUnitListProvider = FutureProvider<List<TrainingCourseUnit>>((ref) async {
  return ref.watch(trainingCourseUnitRepositoryProvider).getAll();
});

final trainingCourseUnitDetailProvider = FutureProvider.family<TrainingCourseUnit, String>((ref, id) async {
  return ref.watch(trainingCourseUnitRepositoryProvider).getById(id);
});
