import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/persons_repository.dart';

class PersonFormPage extends ConsumerStatefulWidget {
  final String? personId;
  const PersonFormPage({super.key, this.personId});

  @override
  ConsumerState<PersonFormPage> createState() => _PersonFormPageState();
}

class _PersonFormPageState extends ConsumerState<PersonFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.personId != null) {
      _loadPerson();
    }
  }

  Future<void> _loadPerson() async {
    setState(() => _isLoading = true);
    try {
      final person = await ref.read(personsRepositoryProvider).getPersonById(widget.personId!);
      _firstNameController.text = person.firstName;
      _lastNameController.text = person.lastName;
      _emailController.text = person.email ?? '';
      _phoneController.text = person.phone ?? '';
    } catch (e) {
      if (mounted) FeedbackService.showError(context, 'Failed to load person');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final data = {
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'display_name': '${_firstNameController.text} ${_lastNameController.text}',
        'email': _emailController.text.isEmpty ? null : _emailController.text,
        'phone': _phoneController.text.isEmpty ? null : _phoneController.text,
      };

      if (widget.personId != null) {
        await ref.read(personsRepositoryProvider).updatePerson(widget.personId!, data);
        if (mounted) FeedbackService.showSuccess(context, 'Person updated successfully');
      } else {
        await ref.read(personsRepositoryProvider).createPerson(data);
        if (mounted) FeedbackService.showSuccess(context, 'Person created successfully');
      }
      
      if (mounted) {
        // Invalidate list to trigger refresh on dashboard
        ref.invalidate(personsListProvider);
        context.pop();
      }
    } catch (e) {
      if (mounted) FeedbackService.showError(context, e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.personId != null ? 'Edit Person' : 'New Person'),
      ),
      body: _isLoading && widget.personId != null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(labelText: 'First Name'),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _save,
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(widget.personId != null ? 'Update' : 'Create'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
