import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/message_model.dart';

class CommMessageRepository {
  final SupabaseClient _client;

  CommMessageRepository(this._client);

  Future<List<CommMessage>> getAll() async {
    final response = await _client
        .from('comm.messages')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommMessage.fromJson(e)).toList();
  }

  Future<CommMessage> getById(String id) async {
    final response = await _client
        .from('comm.messages')
        .select()
        .eq('id', id)
        .single();
    return CommMessage.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('comm.messages').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('comm.messages').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('comm.messages').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final commMessageRepositoryProvider = Provider<CommMessageRepository>((ref) {
  return CommMessageRepository(Supabase.instance.client);
});

final commMessageListProvider = FutureProvider<List<CommMessage>>((ref) async {
  return ref.watch(commMessageRepositoryProvider).getAll();
});

final commMessageDetailProvider = FutureProvider.family<CommMessage, String>((ref, id) async {
  return ref.watch(commMessageRepositoryProvider).getById(id);
});
