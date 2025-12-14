import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/support_models.dart';

class SupportRepository {
  final SupabaseClient _client;

  SupportRepository(this._client);

  Future<List<NexusFile>> getFiles() async {
    final response = await _client.from('nexus.files').select().order('created_at', ascending: false);
    return (response as List).map((e) => NexusFile.fromJson(e)).toList();
  }

  Future<List<Comment>> getCommentsTracker() async {
    // This table tracks comments across modules
    final response = await _client.from('nexus.comments_tracker').select().order('created_at', ascending: false);
    return (response as List).map((e) => Comment.fromJson(e)).toList();
  }
}

final supportRepositoryProvider = Provider<SupportRepository>((ref) {
  return SupportRepository(Supabase.instance.client);
});

final nexusFilesListProvider = FutureProvider<List<NexusFile>>((ref) async {
  return ref.watch(supportRepositoryProvider).getFiles();
});

final commentsTrackerListProvider = FutureProvider<List<Comment>>((ref) async {
  return ref.watch(supportRepositoryProvider).getCommentsTracker();
});
