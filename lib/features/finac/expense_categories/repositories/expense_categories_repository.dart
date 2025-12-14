import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/expense_categorie_model.dart';

class FinacExpenseCategorieRepository {
  final SupabaseClient _client;

  FinacExpenseCategorieRepository(this._client);

  Future<List<FinacExpenseCategorie>> getAll() async {
    final response = await _client
        .from('finac.expense_categories')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => FinacExpenseCategorie.fromJson(e)).toList();
  }

  Future<FinacExpenseCategorie> getById(String id) async {
    final response = await _client
        .from('finac.expense_categories')
        .select()
        .eq('id', id)
        .single();
    return FinacExpenseCategorie.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('finac.expense_categories').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('finac.expense_categories').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('finac.expense_categories').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final finacExpenseCategorieRepositoryProvider = Provider<FinacExpenseCategorieRepository>((ref) {
  return FinacExpenseCategorieRepository(Supabase.instance.client);
});

final finacExpenseCategorieListProvider = FutureProvider<List<FinacExpenseCategorie>>((ref) async {
  return ref.watch(finacExpenseCategorieRepositoryProvider).getAll();
});

final finacExpenseCategorieDetailProvider = FutureProvider.family<FinacExpenseCategorie, String>((ref, id) async {
  return ref.watch(finacExpenseCategorieRepositoryProvider).getById(id);
});
