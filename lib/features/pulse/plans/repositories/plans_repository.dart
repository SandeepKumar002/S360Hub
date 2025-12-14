import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/plan_model.dart';

class PlansRepository {
  final SupabaseClient _client;

  PlansRepository(this._client);

  Future<List<SubscriptionPlan>> getPlans() async {
    final response = await _client
        .from('pulse.plans')
        .select()
        .eq('is_deleted', false)
        .order('price');
    return (response as List).map((e) => SubscriptionPlan.fromJson(e)).toList();
  }

  Future<SubscriptionPlan> getPlanById(String id) async {
    final response = await _client
        .from('pulse.plans')
        .select()
        .eq('id', id)
        .single();
    return SubscriptionPlan.fromJson(response);
  }

  Future<void> createPlan(Map<String, dynamic> data) async {
    await _client.from('pulse.plans').insert(data);
  }

  Future<void> updatePlan(String id, Map<String, dynamic> data) async {
    await _client.from('pulse.plans').update(data).eq('id', id);
  }

  Future<void> deletePlan(String id) async {
    // Soft delete
    await _client.from('pulse.plans').update({
      'is_deleted': true,
      'deleted_at': DateTime.now().toIso8601String(),
    }).eq('id', id);
  }
}

final plansRepositoryProvider = Provider<PlansRepository>((ref) {
  return PlansRepository(Supabase.instance.client);
});

final plansListProvider = FutureProvider<List<SubscriptionPlan>>((ref) async {
  return ref.watch(plansRepositoryProvider).getPlans();
});

final planDetailProvider = FutureProvider.family<SubscriptionPlan, String>((ref, id) async {
  return ref.watch(plansRepositoryProvider).getPlanById(id);
});
