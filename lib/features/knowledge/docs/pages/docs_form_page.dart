import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/docs_repository.dart';

class KnowledgeDocFormPage extends ConsumerStatefulWidget {
  final String? id;
  const KnowledgeDocFormPage({super.key, this.id});

  @override
  ConsumerState<KnowledgeDocFormPage> createState() => _FormState();
}

class _FormState extends ConsumerState<KnowledgeDocFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Controllers
  final _titleController = TextEditingController();
  final _slugController = TextEditingController();
  final _contentController = TextEditingController();
  final _docTypeController = TextEditingController();
  final _statusController = TextEditingController();
  final _tagsController = TextEditingController();

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
      'title': _titleController.text,
      'slug': _slugController.text,
      'content': _contentController.text,
      'doc_type': _docTypeController.text,
      'status': _statusController.text,
      'tags': _tagsController.text,
    };
    
    try {
       if (widget.id != null) {
         await ref.read(knowledgeDocRepositoryProvider).update(widget.id!, data);
         if (mounted) FeedbackService.showSuccess(context, 'Updated successfully');
       } else {
         await ref.read(knowledgeDocRepositoryProvider).create(data);
         if (mounted) FeedbackService.showSuccess(context, 'Created successfully');
       }
       ref.invalidate(knowledgeDocListProvider);
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
               TextFormField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
               const SizedBox(height: 16),
               TextFormField(controller: _slugController, decoration: const InputDecoration(labelText: 'Slug')),
               const SizedBox(height: 16),
               TextFormField(controller: _contentController, decoration: const InputDecoration(labelText: 'Content')),
               const SizedBox(height: 16),
               TextFormField(controller: _docTypeController, decoration: const InputDecoration(labelText: 'DocType')),
               const SizedBox(height: 16),
               TextFormField(controller: _statusController, decoration: const InputDecoration(labelText: 'Status')),
               const SizedBox(height: 16),
               TextFormField(controller: _tagsController, decoration: const InputDecoration(labelText: 'Tags')),
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
