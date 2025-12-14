import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../jobs/models/job_model.dart';
import '../../applications/models/application_model.dart';

class RecruitRepository {
  final SupabaseClient _client;

  RecruitRepository(this._client);

  // Jobs
  Future<List<JobPosting>> getJobs() async {
    final response = await _client
        .from('recruit.jobs')
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((e) => JobPosting.fromJson(e)).toList();
  }

  Future<void> createJob(Map<String, dynamic> data) async {
    await _client.from('recruit.jobs').insert(data);
  }
  
  // Applications
  Future<List<JobApplication>> getApplications() async {
    final response = await _client
        .from('recruit.applications')
        .select()
        .filter('deleted_at', 'is', null)
        .order('applied_at', ascending: false);
    return (response as List).map((e) => JobApplication.fromJson(e)).toList();
  }

  Future<void> createApplication(Map<String, dynamic> data) async {
    await _client.from('recruit.applications').insert(data);
  }
}

final recruitRepositoryProvider = Provider<RecruitRepository>((ref) {
  return RecruitRepository(Supabase.instance.client);
});

final jobsListProvider = FutureProvider<List<JobPosting>>((ref) async {
  return ref.watch(recruitRepositoryProvider).getJobs();
});

final applicationsListProvider = FutureProvider<List<JobApplication>>((ref) async {
  return ref.watch(recruitRepositoryProvider).getApplications();
});
