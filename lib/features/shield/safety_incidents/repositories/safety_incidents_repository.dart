import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/safety_incident_model.dart';

class ShieldSafetyIncidentRepository {
  final SupabaseClient _client;

  ShieldSafetyIncidentRepository(this._client);

  Future<List<ShieldSafetyIncident>> getAll() async {
    final response = await _client
        .from('shield.safety_incidents')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ShieldSafetyIncident.fromJson(e)).toList();
  }

  Future<ShieldSafetyIncident> getById(String id) async {
    final response = await _client
        .from('shield.safety_incidents')
        .select()
        .eq('id', id)
        .single();
    return ShieldSafetyIncident.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('shield.safety_incidents').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('shield.safety_incidents').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('shield.safety_incidents').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final shieldSafetyIncidentRepositoryProvider = Provider<ShieldSafetyIncidentRepository>((ref) {
  return ShieldSafetyIncidentRepository(Supabase.instance.client);
});

final shieldSafetyIncidentListProvider = FutureProvider<List<ShieldSafetyIncident>>((ref) async {
  return ref.watch(shieldSafetyIncidentRepositoryProvider).getAll();
});

final shieldSafetyIncidentDetailProvider = FutureProvider.family<ShieldSafetyIncident, String>((ref, id) async {
  return ref.watch(shieldSafetyIncidentRepositoryProvider).getById(id);
});
