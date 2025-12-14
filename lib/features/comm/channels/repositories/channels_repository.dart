import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/channel_model.dart';

class CommChannelRepository {
  final SupabaseClient _client;

  CommChannelRepository(this._client);

  Future<List<CommChannel>> getAll() async {
    final response = await _client
        .from('comm.channels')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommChannel.fromJson(e)).toList();
  }

  Future<CommChannel> getById(String id) async {
    final response = await _client
        .from('comm.channels')
        .select()
        .eq('id', id)
        .single();
    return CommChannel.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('comm.channels').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('comm.channels').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('comm.channels').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final commChannelRepositoryProvider = Provider<CommChannelRepository>((ref) {
  return CommChannelRepository(Supabase.instance.client);
});

final commChannelListProvider = FutureProvider<List<CommChannel>>((ref) async {
  return ref.watch(commChannelRepositoryProvider).getAll();
});

final commChannelDetailProvider = FutureProvider.family<CommChannel, String>((ref, id) async {
  return ref.watch(commChannelRepositoryProvider).getById(id);
});
