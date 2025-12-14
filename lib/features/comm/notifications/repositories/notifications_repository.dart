import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/notification_model.dart';

class CommNotificationRepository {
  final SupabaseClient _client;

  CommNotificationRepository(this._client);

  Future<List<CommNotification>> getAll() async {
    final response = await _client
        .from('comm.notifications')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommNotification.fromJson(e)).toList();
  }

  Future<CommNotification> getById(String id) async {
    final response = await _client
        .from('comm.notifications')
        .select()
        .eq('id', id)
        .single();
    return CommNotification.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('comm.notifications').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('comm.notifications').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('comm.notifications').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final commNotificationRepositoryProvider = Provider<CommNotificationRepository>((ref) {
  return CommNotificationRepository(Supabase.instance.client);
});

final commNotificationListProvider = FutureProvider<List<CommNotification>>((ref) async {
  return ref.watch(commNotificationRepositoryProvider).getAll();
});

final commNotificationDetailProvider = FutureProvider.family<CommNotification, String>((ref, id) async {
  return ref.watch(commNotificationRepositoryProvider).getById(id);
});
