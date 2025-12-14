import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/addresses_repository.dart';

class AddressFormPage extends ConsumerStatefulWidget {
  final String? addressId;
  const AddressFormPage({super.key, this.addressId});

  @override
  ConsumerState<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends ConsumerState<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController(); // Should be Dropdown ideally
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();
  
  bool _isLoading = false;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    if (widget.addressId != null) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final address = await ref.read(addressesRepositoryProvider).getAddressById(widget.addressId!);
      _typeController.text = address.addressType ?? '';
      _line1Controller.text = address.line1 ?? '';
      _line2Controller.text = address.line2 ?? '';
      _cityController.text = address.city ?? '';
      _stateController.text = address.state ?? '';
      _zipController.text = address.pincode ?? '';
      _isDefault = address.isDefault;
    } catch (e) {
      if(mounted) FeedbackService.showError(context, 'Failed to load address');
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final data = {
      'address_type': _typeController.text,
      'line1': _line1Controller.text,
      'line2': _line2Controller.text,
      'city': _cityController.text,
      'state': _stateController.text,
      'pincode': _zipController.text,
      'is_default': _isDefault,
      // 'country': 'India', // Default or selector
    };

    try {
      if (widget.addressId != null) {
        await ref.read(addressesRepositoryProvider).updateAddress(widget.addressId!, data);
         if(mounted) FeedbackService.showSuccess(context, 'Address Updated');
      } else {
         // Create requires owner_id usually. For standalone CRUD, we might create orphan or need generic handler. 
         // Assuming user handles linking logic elsewhere or this is just admin view.
         await ref.read(addressesRepositoryProvider).createAddress(data);
         if(mounted) FeedbackService.showSuccess(context, 'Address Created');
      }
      
      if (mounted) {
         ref.invalidate(addressesListProvider);
         context.pop();
      }
    } catch(e) {
      if(mounted) FeedbackService.showError(context, e.toString());
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.addressId != null ? 'Edit Address' : 'New Address')),
      body: _isLoading && widget.addressId != null
       ? const Center(child: CircularProgressIndicator())
       : SingleChildScrollView(
         padding: const EdgeInsets.all(16),
         child: Form(
           key: _formKey,
           child: Column(
             children: [
               TextFormField(controller: _typeController, decoration: const InputDecoration(labelText: 'Type (Home, Office)')),
               const SizedBox(height: 16),
               TextFormField(controller: _line1Controller, decoration: const InputDecoration(labelText: 'Line 1'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 16),
               TextFormField(controller: _line2Controller, decoration: const InputDecoration(labelText: 'Line 2')),
               const SizedBox(height: 16),
               Row(children: [
                 Expanded(child: TextFormField(controller: _cityController, decoration: const InputDecoration(labelText: 'City'))),
                 const SizedBox(width: 16),
                 Expanded(child: TextFormField(controller: _stateController, decoration: const InputDecoration(labelText: 'State'))),
               ]),
               const SizedBox(height: 16),
               TextFormField(controller: _zipController, decoration: const InputDecoration(labelText: 'Pincode')),
               const SizedBox(height: 16),
               CheckboxListTile(title: const Text('Is Default'), value: _isDefault, onChanged: (v) => setState(() => _isDefault = v ?? false)),
               const SizedBox(height: 32),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: Text('Save')),
             ],
           ),
         ),
       ),
    );
  }
}
