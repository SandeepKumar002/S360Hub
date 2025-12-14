import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/expense_claim_model.dart';

class ExpensesRepository {
  final SupabaseClient _client;

  ExpensesRepository(this._client);

  Future<List<ExpenseClaim>> getClaims() async {
    final response = await _client
        .from('staffie.expense_claims')
        .select()
        .order('claim_date', ascending: false);
    return (response as List).map((e) => ExpenseClaim.fromJson(e)).toList();
  }
}

final expensesRepositoryProvider = Provider<ExpensesRepository>((ref) {
  return ExpensesRepository(Supabase.instance.client);
});

final expensesListProvider = FutureProvider<List<ExpenseClaim>>((ref) async {
  return ref.watch(expensesRepositoryProvider).getClaims();
});
