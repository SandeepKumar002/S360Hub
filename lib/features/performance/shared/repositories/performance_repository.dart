import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../goals/models/objective_model.dart';
import '../../reviews/models/review_model.dart';

class PerformanceRepository {
  final SupabaseClient _client;

  PerformanceRepository(this._client);

  // Objectives (OKRs)
  Future<List<Objective>> getObjectives() async {
    final response = await _client
        .from('performance.objectives')
        .select()
        .filter('deleted_at', 'is', null)
        .order('due_date', ascending: true);
    return (response as List).map((e) => Objective.fromJson(e)).toList();
  }

  // Reviews
  Future<List<PerformanceReview>> getReviews() async {
    final response = await _client
        .from('performance.reviews')
        .select()
        .filter('deleted_at', 'is', null)
        .order('created_at', ascending: false);
    return (response as List).map((e) => PerformanceReview.fromJson(e)).toList();
  }
}

final performanceRepositoryProvider = Provider<PerformanceRepository>((ref) {
  return PerformanceRepository(Supabase.instance.client);
});

final objectivesListProvider = FutureProvider<List<Objective>>((ref) async {
  return ref.watch(performanceRepositoryProvider).getObjectives();
});

final reviewsListProvider = FutureProvider<List<PerformanceReview>>((ref) async {
  return ref.watch(performanceRepositoryProvider).getReviews();
});
