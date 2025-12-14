import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/posh_complaint_model.dart';

class ShieldPoshComplaintRepository {
  final SupabaseClient _client;

  ShieldPoshComplaintRepository(this._client);

  Future<List<ShieldPoshComplaint>> getAll() async {
    final response = await _client
        .from('shield.posh_complaints')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ShieldPoshComplaint.fromJson(e)).toList();
  }

  Future<ShieldPoshComplaint> getById(String id) async {
    final response = await _client
        .from('shield.posh_complaints')
        .select()
        .eq('id', id)
        .single();
    return ShieldPoshComplaint.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('shield.posh_complaints').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('shield.posh_complaints').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('shield.posh_complaints').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final shieldPoshComplaintRepositoryProvider = Provider<ShieldPoshComplaintRepository>((ref) {
  return ShieldPoshComplaintRepository(Supabase.instance.client);
});

final shieldPoshComplaintListProvider = FutureProvider<List<ShieldPoshComplaint>>((ref) async {
  return ref.watch(shieldPoshComplaintRepositoryProvider).getAll();
});

final shieldPoshComplaintDetailProvider = FutureProvider.family<ShieldPoshComplaint, String>((ref, id) async {
  return ref.watch(shieldPoshComplaintRepositoryProvider).getById(id);
});
