import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/channel_member_model.dart';

class CommChannelMemberRepository {
  final SupabaseClient _client;

  CommChannelMemberRepository(this._client);

  Future<List<CommChannelMember>> getAll() async {
    final response = await _client
        .from('comm.channel_members')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => CommChannelMember.fromJson(e)).toList();
  }

  Future<CommChannelMember> getById(String id) async {
    final response = await _client
        .from('comm.channel_members')
        .select()
        .eq('id', id)
        .single();
    return CommChannelMember.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('comm.channel_members').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('comm.channel_members').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('comm.channel_members').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final commChannelMemberRepositoryProvider = Provider<CommChannelMemberRepository>((ref) {
  return CommChannelMemberRepository(Supabase.instance.client);
});

final commChannelMemberListProvider = FutureProvider<List<CommChannelMember>>((ref) async {
  return ref.watch(commChannelMemberRepositoryProvider).getAll();
});

final commChannelMemberDetailProvider = FutureProvider.family<CommChannelMember, String>((ref, id) async {
  return ref.watch(commChannelMemberRepositoryProvider).getById(id);
});
