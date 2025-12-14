import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/contractor_staff_model.dart';

class ContracforceContractorStaffRepository {
  final SupabaseClient _client;

  ContracforceContractorStaffRepository(this._client);

  Future<List<ContracforceContractorStaff>> getAll() async {
    final response = await _client
        .from('contracforce.contractor_staff')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => ContracforceContractorStaff.fromJson(e)).toList();
  }

  Future<ContracforceContractorStaff> getById(String id) async {
    final response = await _client
        .from('contracforce.contractor_staff')
        .select()
        .eq('id', id)
        .single();
    return ContracforceContractorStaff.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('contracforce.contractor_staff').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('contracforce.contractor_staff').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('contracforce.contractor_staff').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final contracforceContractorStaffRepositoryProvider = Provider<ContracforceContractorStaffRepository>((ref) {
  return ContracforceContractorStaffRepository(Supabase.instance.client);
});

final contracforceContractorStaffListProvider = FutureProvider<List<ContracforceContractorStaff>>((ref) async {
  return ref.watch(contracforceContractorStaffRepositoryProvider).getAll();
});

final contracforceContractorStaffDetailProvider = FutureProvider.family<ContracforceContractorStaff, String>((ref, id) async {
  return ref.watch(contracforceContractorStaffRepositoryProvider).getById(id);
});
