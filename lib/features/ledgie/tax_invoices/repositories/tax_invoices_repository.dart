import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tax_invoice_model.dart';

class LedgieTaxInvoiceRepository {
  final SupabaseClient _client;

  LedgieTaxInvoiceRepository(this._client);

  Future<List<LedgieTaxInvoice>> getAll() async {
    final response = await _client
        .from('ledgie.tax_invoices')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieTaxInvoice.fromJson(e)).toList();
  }

  Future<LedgieTaxInvoice> getById(String id) async {
    final response = await _client
        .from('ledgie.tax_invoices')
        .select()
        .eq('id', id)
        .single();
    return LedgieTaxInvoice.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.tax_invoices').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.tax_invoices').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.tax_invoices').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieTaxInvoiceRepositoryProvider = Provider<LedgieTaxInvoiceRepository>((ref) {
  return LedgieTaxInvoiceRepository(Supabase.instance.client);
});

final ledgieTaxInvoiceListProvider = FutureProvider<List<LedgieTaxInvoice>>((ref) async {
  return ref.watch(ledgieTaxInvoiceRepositoryProvider).getAll();
});

final ledgieTaxInvoiceDetailProvider = FutureProvider.family<LedgieTaxInvoice, String>((ref, id) async {
  return ref.watch(ledgieTaxInvoiceRepositoryProvider).getById(id);
});
