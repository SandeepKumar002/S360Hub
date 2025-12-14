import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/proforma_invoice_model.dart';

class LedgieProformaInvoiceRepository {
  final SupabaseClient _client;

  LedgieProformaInvoiceRepository(this._client);

  Future<List<LedgieProformaInvoice>> getAll() async {
    final response = await _client
        .from('ledgie.proforma_invoices')
        .select()
        .filter('deleted_at', 'is', null) 
        .order('created_at', ascending: false);
    return (response as List).map((e) => LedgieProformaInvoice.fromJson(e)).toList();
  }

  Future<LedgieProformaInvoice> getById(String id) async {
    final response = await _client
        .from('ledgie.proforma_invoices')
        .select()
        .eq('id', id)
        .single();
    return LedgieProformaInvoice.fromJson(response);
  }

  Future<void> create(Map<String, dynamic> data) async {
    await _client.from('ledgie.proforma_invoices').insert(data);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _client.from('ledgie.proforma_invoices').update(data).eq('id', id);
  }
  
  Future<void> delete(String id) async {
     await _client.from('ledgie.proforma_invoices').update({
       'deleted_at': DateTime.now().toIso8601String(),
     }).eq('id', id);
  }
}

final ledgieProformaInvoiceRepositoryProvider = Provider<LedgieProformaInvoiceRepository>((ref) {
  return LedgieProformaInvoiceRepository(Supabase.instance.client);
});

final ledgieProformaInvoiceListProvider = FutureProvider<List<LedgieProformaInvoice>>((ref) async {
  return ref.watch(ledgieProformaInvoiceRepositoryProvider).getAll();
});

final ledgieProformaInvoiceDetailProvider = FutureProvider.family<LedgieProformaInvoice, String>((ref, id) async {
  return ref.watch(ledgieProformaInvoiceRepositoryProvider).getById(id);
});
