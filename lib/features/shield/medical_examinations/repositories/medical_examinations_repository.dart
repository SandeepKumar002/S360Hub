import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/medical_examination_model.dart';

class ShieldMedicalExaminationRepository {
  final SupabaseClient _client;

  ShieldMedicalExaminationRepository(this._client);

  Future<List<ShieldMedicalExamination>> getAll() async {
    final response = await _client
        .from('shield.medical_examinations')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ShieldMedicalExamination.fromJson(e)).toList();
  }

  Future<ShieldMedicalExamination> getById(String id) async {
    final response = await _client
        .from('shield.medical_examinations')
        .select()
        .eq('id', id)
        .single();
    return ShieldMedicalExamination.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('shield.medical_examinations').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('shield.medical_examinations').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('shield.medical_examinations').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final shieldMedicalExaminationRepositoryProvider = Provider<ShieldMedicalExaminationRepository>((ref) {
  return ShieldMedicalExaminationRepository(Supabase.instance.client);
});

final shieldMedicalExaminationListProvider = FutureProvider<List<ShieldMedicalExamination>>((ref) async {
  return ref.watch(shieldMedicalExaminationRepositoryProvider).getAll();
});

final shieldMedicalExaminationDetailProvider = FutureProvider.family<ShieldMedicalExamination, String>((ref, id) async {
  return ref.watch(shieldMedicalExaminationRepositoryProvider).getById(id);
});
