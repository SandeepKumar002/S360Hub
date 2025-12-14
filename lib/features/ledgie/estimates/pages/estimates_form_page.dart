import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/estimates_repository.dart';

class LedgieEstimateFormPage extends ConsumerStatefulWidget {
  final String? id;
  const LedgieEstimateFormPage({super.key, this.id});

  @override
  ConsumerState<LedgieEstimateFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<LedgieEstimateFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _proposalIdController = TextEditingController();
  final _estimateNumberController = TextEditingController();
  final _estimateDateController = TextEditingController();
  final _entityIdController = TextEditingController();
  final _entityCodeController = TextEditingController();
  final _entityNameController = TextEditingController();
  final _entityContactNameController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _districtController = TextEditingController();
  final _subDistrictController = TextEditingController();
  final _addressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _gstinController = TextEditingController();
  final _panController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _sectorController = TextEditingController();
  final _hsnSacCodesController = TextEditingController();
  final _serviceTypeController = TextEditingController();
  final _quoteValidityDaysController = TextEditingController();
  final _serviceDescriptionController = TextEditingController();
  final _numberOfUnitsController = TextEditingController();
  final _currencyController = TextEditingController();
  final _estimatedCostsController = TextEditingController();
  final _paymentRetainerPctController = TextEditingController();
  final _retainerValueController = TextEditingController();
  final _balancePctController = TextEditingController();
  final _balanceValueController = TextEditingController();
  final _statusController = TextEditingController();
  final _deletedByController = TextEditingController();
  final _deleteTypeController = TextEditingController();
  bool _isDeleted = false;
  final _leadsProspectIdController = TextEditingController();

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
      'proposal_id': _proposalIdController.text,
      'estimate_number': _estimateNumberController.text,
      'estimate_date': _estimateDateController.text,
      'entity_id': _entityIdController.text,
      'entity_code': _entityCodeController.text,
      'entity_name': _entityNameController.text,
      'entity_contact_name': _entityContactNameController.text,
      'country': _countryController.text,
      'state': _stateController.text,
      'district': _districtController.text,
      'sub_district': _subDistrictController.text,
      'address': _addressController.text,
      'pincode': _pincodeController.text,
      'gstin': _gstinController.text,
      'pan': _panController.text,
      'start_date': _startDateController.text,
      'end_date': _endDateController.text,
      'sector': _sectorController.text,
      'hsn_sac_codes': _hsnSacCodesController.text,
      'service_type': _serviceTypeController.text,
      'quote_validity_days': int.tryParse(_quoteValidityDaysController.text),
      'service_description': _serviceDescriptionController.text,
      'number_of_units': int.tryParse(_numberOfUnitsController.text),
      'currency': _currencyController.text,
      'estimated_costs': double.tryParse(_estimatedCostsController.text),
      'payment_retainer_pct': double.tryParse(_paymentRetainerPctController.text),
      'retainer_value': double.tryParse(_retainerValueController.text),
      'balance_pct': double.tryParse(_balancePctController.text),
      'balance_value': double.tryParse(_balanceValueController.text),
      'status': _statusController.text,
      'deleted_by': _deletedByController.text,
      'delete_type': _deleteTypeController.text,
      'is_deleted': _isDeleted,
      'leads_prospect_id': _leadsProspectIdController.text,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(ledgieEstimateRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(ledgieEstimateRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(ledgieEstimateListProvider);
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
               TextFormField(controller: _proposalIdController, decoration: const InputDecoration(labelText: 'ProposalId')),
               const SizedBox(height: 16),
               TextFormField(controller: _estimateNumberController, decoration: const InputDecoration(labelText: 'EstimateNumber')),
               const SizedBox(height: 16),
               TextFormField(controller: _estimateDateController, decoration: const InputDecoration(labelText: 'EstimateDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _entityIdController, decoration: const InputDecoration(labelText: 'EntityId')),
               const SizedBox(height: 16),
               TextFormField(controller: _entityCodeController, decoration: const InputDecoration(labelText: 'EntityCode')),
               const SizedBox(height: 16),
               TextFormField(controller: _entityNameController, decoration: const InputDecoration(labelText: 'EntityName')),
               const SizedBox(height: 16),
               TextFormField(controller: _entityContactNameController, decoration: const InputDecoration(labelText: 'EntityContactName')),
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
               TextFormField(controller: _startDateController, decoration: const InputDecoration(labelText: 'StartDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _endDateController, decoration: const InputDecoration(labelText: 'EndDate')),
               const SizedBox(height: 16),
               TextFormField(controller: _sectorController, decoration: const InputDecoration(labelText: 'Sector')),
               const SizedBox(height: 16),
               TextFormField(controller: _hsnSacCodesController, decoration: const InputDecoration(labelText: 'HsnSacCodes')),
               const SizedBox(height: 16),
               TextFormField(controller: _serviceTypeController, decoration: const InputDecoration(labelText: 'ServiceType')),
               const SizedBox(height: 16),
               TextFormField(controller: _quoteValidityDaysController, decoration: const InputDecoration(labelText: 'QuoteValidityDays')),
               const SizedBox(height: 16),
               TextFormField(controller: _serviceDescriptionController, decoration: const InputDecoration(labelText: 'ServiceDescription')),
               const SizedBox(height: 16),
               TextFormField(controller: _numberOfUnitsController, decoration: const InputDecoration(labelText: 'NumberOfUnits')),
               const SizedBox(height: 16),
               TextFormField(controller: _currencyController, decoration: const InputDecoration(labelText: 'Currency')),
               const SizedBox(height: 16),
               TextFormField(controller: _estimatedCostsController, decoration: const InputDecoration(labelText: 'EstimatedCosts')),
               const SizedBox(height: 16),
               TextFormField(controller: _paymentRetainerPctController, decoration: const InputDecoration(labelText: 'PaymentRetainerPct')),
               const SizedBox(height: 16),
               TextFormField(controller: _retainerValueController, decoration: const InputDecoration(labelText: 'RetainerValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _balancePctController, decoration: const InputDecoration(labelText: 'BalancePct')),
               const SizedBox(height: 16),
               TextFormField(controller: _balanceValueController, decoration: const InputDecoration(labelText: 'BalanceValue')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _deletedByController, decoration: const InputDecoration(labelText: 'DeletedBy')),
               const SizedBox(height: 16),
               TextFormField(controller: _deleteTypeController, decoration: const InputDecoration(labelText: 'DeleteType')),
               const SizedBox(height: 16),
               SwitchListTile(title: const Text('IsDeleted'), value: _isDeleted, onChanged: (v) => setState(() => _isDeleted = v)),
               TextFormField(controller: _leadsProspectIdController, decoration: const InputDecoration(labelText: 'LeadsProspectId')),
               const SizedBox(height: 16),
               const SizedBox(height: 24),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: const Text('Save')),
             ],
          ),
        ),
      ),
    );
  }
}
