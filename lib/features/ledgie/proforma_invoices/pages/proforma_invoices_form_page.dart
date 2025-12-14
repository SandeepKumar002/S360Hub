import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/proforma_invoices_repository.dart';

class LedgieProformaInvoiceFormPage extends ConsumerStatefulWidget {
  final String? id;
  const LedgieProformaInvoiceFormPage({super.key, this.id});

  @override
  ConsumerState<LedgieProformaInvoiceFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<LedgieProformaInvoiceFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _entityTypeController = TextEditingController();
  final _proformaTypeController = TextEditingController();
  final _serviceOrderIdController = TextEditingController();
  final _proposalIdController = TextEditingController();
  final _estimateIdController = TextEditingController();
  final _proformaNumberController = TextEditingController();
  final _invoiceToNameController = TextEditingController();
  final _entityIdController = TextEditingController();
  final _entityCodeController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _districtController = TextEditingController();
  final _subDistrictController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _gstinController = TextEditingController();
  final _panController = TextEditingController();
  final _paymentTypeController = TextEditingController();
  final _paymentTermDaysController = TextEditingController();
  final _invoiceDateController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _currencyController = TextEditingController();
  final _agreedValueController = TextEditingController();
  final _invoiceValueController = TextEditingController();
  final _tdsPercentController = TextEditingController();
  final _tdsValueController = TextEditingController();
  final _cgstPercentController = TextEditingController();
  final _sgstPercentController = TextEditingController();
  final _igstPercentController = TextEditingController();
  final _cgstValueController = TextEditingController();
  final _sgstValueController = TextEditingController();
  final _igstValueController = TextEditingController();
  final _totalValueController = TextEditingController();
  final _statusController = TextEditingController();
  final _deletedByController = TextEditingController();
  final _deleteTypeController = TextEditingController();
  bool _isDeleted = false;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _loadData();
    }
  }
  
  Future<void> _loadData() async {
    // TODO: Load data for edit
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final data = {
      'entity_type': _entityTypeController.text,
      'proforma_type': _proformaTypeController.text,
      'service_order_id': _serviceOrderIdController.text,
      'proposal_id': _proposalIdController.text,
      'estimate_id': _estimateIdController.text,
      'proforma_number': _proformaNumberController.text,
      'invoice_to_name': _invoiceToNameController.text,
      'entity_id': _entityIdController.text,
      'entity_code': _entityCodeController.text,
      'contact_name': _contactNameController.text,
      'country': _countryController.text,
      'state': _stateController.text,
      'district': _districtController.text,
      'sub_district': _subDistrictController.text,
      'address': _addressController.text,
      'pincode': _pincodeController.text,
      'gstin': _gstinController.text,
      'pan': _panController.text,
      'payment_type': _paymentTypeController.text,
      'payment_term_days': int.tryParse(_paymentTermDaysController.text),
      'invoice_date': _invoiceDateController.text,
      'due_date': _dueDateController.text,
      'currency': _currencyController.text,
      'agreed_value': double.tryParse(_agreedValueController.text),
      'invoice_value': double.tryParse(_invoiceValueController.text),
      'tds_percent': double.tryParse(_tdsPercentController.text),
      'tds_value': double.tryParse(_tdsValueController.text),
      'cgst_percent': double.tryParse(_cgstPercentController.text),
      'sgst_percent': double.tryParse(_sgstPercentController.text),
      'igst_percent': double.tryParse(_igstPercentController.text),
      'cgst_value': double.tryParse(_cgstValueController.text),
      'sgst_value': double.tryParse(_sgstValueController.text),
      'igst_value': double.tryParse(_igstValueController.text),
      'total_value': double.tryParse(_totalValueController.text),
      'status': _statusController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(ledgieProformaInvoiceRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(ledgieProformaInvoiceRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(ledgieProformaInvoiceListProvider);
       if (mounted) context.pop();
    } catch (e) {
       if (mounted) FeedbackService.showError(context, e.toString());
    } finally {
       if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.id != null ? 'Edit' : 'New')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
             children: [
               TextFormField(controller: _entityTypeController, decoration: const InputDecoration(labelText: 'EntityType')),
               const SizedBox(height: 16),
               TextFormField(controller: _proformaTypeController, decoration: const InputDecoration(labelText: 'ProformaType')),
               const SizedBox(height: 16),
               TextFormField(controller: _serviceOrderIdController, decoration: const InputDecoration(labelText: 'ServiceOrderId')),
               const SizedBox(height: 16),
               TextFormField(controller: _proposalIdController, decoration: const InputDecoration(labelText: 'ProposalId')),
               const SizedBox(height: 16),
               TextFormField(controller: _estimateIdController, decoration: const InputDecoration(labelText: 'EstimateId')),
               const SizedBox(height: 16),
               TextFormField(controller: _proformaNumberController, decoration: const InputDecoration(labelText: 'ProformaNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _invoiceToNameController, decoration: const InputDecoration(labelText: 'InvoiceToName')),
               const SizedBox(height: 16),
               TextFormField(controller: _entityIdController, decoration: const InputDecoration(labelText: 'EntityId')),
               const SizedBox(height: 16),
               TextFormField(controller: _entityCodeController, decoration: const InputDecoration(labelText: 'EntityCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _contactNameController, decoration: const InputDecoration(labelText: 'ContactName')),
               const SizedBox(height: 16),
               TextFormField(controller: _countryController, decoration: const InputDecoration(labelText: 'Country')),
               const SizedBox(height: 16),
               TextFormField(controller: _stateController, decoration: const InputDecoration(labelText: 'State')),
               const SizedBox(height: 16),
               TextFormField(controller: _districtController, decoration: const InputDecoration(labelText: 'District')),
               const SizedBox(height: 16),
               TextFormField(controller: _subDistrictController, decoration: const InputDecoration(labelText: 'SubDistrict')),
               const SizedBox(height: 16),
               TextFormField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address')),
               const SizedBox(height: 16),
               TextFormField(controller: _pincodeController, decoration: const InputDecoration(labelText: 'Pincode')),
               const SizedBox(height: 16),
               TextFormField(controller: _gstinController, decoration: const InputDecoration(labelText: 'Gstin')),
               const SizedBox(height: 16),
               TextFormField(controller: _panController, decoration: const InputDecoration(labelText: 'Pan')),
               const SizedBox(height: 16),
               TextFormField(controller: _paymentTypeController, decoration: const InputDecoration(labelText: 'PaymentType')),
               const SizedBox(height: 16),
               TextFormField(controller: _paymentTermDaysController, decoration: const InputDecoration(labelText: 'PaymentTermDays')),
               const SizedBox(height: 16),
               TextFormField(controller: _invoiceDateController, decoration: const InputDecoration(labelText: 'InvoiceDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _dueDateController, decoration: const InputDecoration(labelText: 'DueDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _currencyController, decoration: const InputDecoration(labelText: 'Currency')),
               const SizedBox(height: 16),
               TextFormField(controller: _agreedValueController, decoration: const InputDecoration(labelText: 'AgreedValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _invoiceValueController, decoration: const InputDecoration(labelText: 'InvoiceValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _tdsPercentController, decoration: const InputDecoration(labelText: 'TdsPercent')),
               const SizedBox(height: 16),
               TextFormField(controller: _tdsValueController, decoration: const InputDecoration(labelText: 'TdsValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _cgstPercentController, decoration: const InputDecoration(labelText: 'CgstPercent')),
               const SizedBox(height: 16),
               TextFormField(controller: _sgstPercentController, decoration: const InputDecoration(labelText: 'SgstPercent')),
               const SizedBox(height: 16),
               TextFormField(controller: _igstPercentController, decoration: const InputDecoration(labelText: 'IgstPercent')),
               const SizedBox(height: 16),
               TextFormField(controller: _cgstValueController, decoration: const InputDecoration(labelText: 'CgstValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _sgstValueController, decoration: const InputDecoration(labelText: 'SgstValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _igstValueController, decoration: const InputDecoration(labelText: 'IgstValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _totalValueController, decoration: const InputDecoration(labelText: 'TotalValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _deletedByController, decoration: const InputDecoration(labelText: 'DeletedBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _deleteTypeController, decoration: const InputDecoration(labelText: 'DeleteType')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsDeleted'), value: _isDeleted, onChanged: (v) => setState(() => _isDeleted = v)),
               const SizedBox(height: 24),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: const Text('Save')),
             ],
          ),
        ),
      ),
    );
  }
}
