import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/organizations_repository.dart';

class OrganizationFormPage extends ConsumerStatefulWidget {
  final String? orgId;
  const OrganizationFormPage({super.key, this.orgId});

  @override
  ConsumerState<OrganizationFormPage> createState() => _OrganizationFormPageState();
}

class _OrganizationFormPageState extends ConsumerState<OrganizationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _domainController = TextEditingController();
  final _capacityController = TextEditingController(text: '5');
  String? _status = 'active';

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.orgId != null) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final org = await ref.read(organizationsRepositoryProvider).getOrganizationById(widget.orgId!);
      _nameController.text = org.name;
      _codeController.text = org.code;
      _domainController.text = org.domain ?? '';
      _capacityController.text = org.userCapacity.toString();
      setState(() => _status = org.status);
    } catch (e) {
      if(mounted) FeedbackService.showError(context, 'Failed to load organization');
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final data = {
      'name': _nameController.text,
      'code': _codeController.text,
      'domain': _domainController.text.isEmpty ? null : _domainController.text,
      'user_capacity': int.tryParse(_capacityController.text) ?? 5,
      'status': _status,
    };

    try {
      if (widget.orgId != null) {
        await ref.read(organizationsRepositoryProvider).updateOrganization(widget.orgId!, data);
         if(mounted) FeedbackService.showSuccess(context, 'Organization Updated');
      } else {
         await ref.read(organizationsRepositoryProvider).createOrganization(data);
         if(mounted) FeedbackService.showSuccess(context, 'Organization Created');
      }
      
      if (mounted) {
         ref.invalidate(organizationsListProvider);
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
      appBar: AppBar(title: Text(widget.orgId != null ? 'Edit Organization' : 'New Organization')),
      body: _isLoading && widget.orgId != null
       ? const Center(child: CircularProgressIndicator())
       : SingleChildScrollView(
         padding: const EdgeInsets.all(16),
         child: Form(
           key: _formKey,
           child: Column(
             children: [
               TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 16),
               TextFormField(controller: _codeController, decoration: const InputDecoration(labelText: 'Code (Unique)'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 16),
               TextFormField(controller: _domainController, decoration: const InputDecoration(labelText: 'Domain (Optional)')),
               const SizedBox(height: 16),
               TextFormField(controller: _capacityController, decoration: const InputDecoration(labelText: 'User Capacity'), keyboardType: TextInputType.number),
               const SizedBox(height: 16),
               DropdownButtonFormField<String>(
                 value: _status,
                 decoration: const InputDecoration(labelText: 'Status'),
                 items: ['active', 'trial', 'suspended'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                 onChanged: (v) => setState(() => _status = v),
               ),
               const SizedBox(height: 32),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: Text('Save')),
             ],
           ),
         ),
       ),
    );
  }
}
