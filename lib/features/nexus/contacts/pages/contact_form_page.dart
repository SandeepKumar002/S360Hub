import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/contacts_repository.dart';

class ContactFormPage extends ConsumerStatefulWidget {
  final String? contactId;
  const ContactFormPage({super.key, this.contactId});

  @override
  ConsumerState<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends ConsumerState<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _designationController = TextEditingController();
  final _typeController = TextEditingController(); // Should be enum/lookup
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.contactId != null) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final contact = await ref.read(contactsRepositoryProvider).getContactById(widget.contactId!);
      _nameController.text = contact.name ?? '';
      _phoneController.text = contact.phone ?? '';
      _emailController.text = contact.email ?? '';
      _designationController.text = contact.designation ?? '';
      _typeController.text = contact.contactType ?? '';
    } catch (e) {
      if(mounted) FeedbackService.showError(context, 'Failed to load contact');
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final data = {
      'name': _nameController.text,
      'phone': _phoneController.text,
      'email': _emailController.text,
      'designation': _designationController.text,
      'contact_type': _typeController.text,
    };

    try {
      if (widget.contactId != null) {
        await ref.read(contactsRepositoryProvider).updateContact(widget.contactId!, data);
         if(mounted) FeedbackService.showSuccess(context, 'Contact Updated');
      } else {
         await ref.read(contactsRepositoryProvider).createContact(data);
         if(mounted) FeedbackService.showSuccess(context, 'Contact Created');
      }
      
      if (mounted) {
         ref.invalidate(contactsListProvider);
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
      appBar: AppBar(title: Text(widget.contactId != null ? 'Edit Contact' : 'New Contact')),
      body: _isLoading && widget.contactId != null
       ? const Center(child: CircularProgressIndicator())
       : SingleChildScrollView(
         padding: const EdgeInsets.all(16),
         child: Form(
           key: _formKey,
           child: Column(
             children: [
               TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 16),
               TextFormField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone')),
               const SizedBox(height: 16),
               TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
               const SizedBox(height: 16),
               TextFormField(controller: _designationController, decoration: const InputDecoration(labelText: 'Designation')),
               const SizedBox(height: 16),
               TextFormField(controller: _typeController, decoration: const InputDecoration(labelText: 'Type (e.g. Primary, Emergency)')),
               const SizedBox(height: 32),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: Text('Save')),
             ],
           ),
         ),
       ),
    );
  }
}
