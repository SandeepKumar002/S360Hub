import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/plans_repository.dart';

class PlanFormPage extends ConsumerStatefulWidget {
  final String? planId;
  const PlanFormPage({super.key, this.planId});

  @override
  ConsumerState<PlanFormPage> createState() => _PlanFormPageState();
}

class _PlanFormPageState extends ConsumerState<PlanFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _priceController = TextEditingController();
  final _seatsController = TextEditingController();
  final _storageController = TextEditingController();
  String _cycle = 'monthly';

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.planId != null) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final plan = await ref.read(plansRepositoryProvider).getPlanById(widget.planId!);
      _nameController.text = plan.displayName;
      _codeController.text = plan.planCode;
      _priceController.text = plan.price.toString();
      _seatsController.text = plan.seatsLimit.toString();
      _storageController.text = plan.storageLimitGb.toString();
      setState(() => _cycle = plan.billingCycle);
    } catch (e) {
      if(mounted) FeedbackService.showError(context, 'Failed to load plan');
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final data = {
      'display_name': _nameController.text,
      'plan_code': _codeController.text,
      'price': double.tryParse(_priceController.text) ?? 0.0,
      'seats_limit': int.tryParse(_seatsController.text) ?? 0,
      'storage_limit_gb': int.tryParse(_storageController.text) ?? 0,
      'billing_cycle': _cycle,
    };

    try {
      if (widget.planId != null) {
        await ref.read(plansRepositoryProvider).updatePlan(widget.planId!, data);
         if(mounted) FeedbackService.showSuccess(context, 'Plan Updated');
      } else {
         await ref.read(plansRepositoryProvider).createPlan(data);
         if(mounted) FeedbackService.showSuccess(context, 'Plan Created');
      }
      
      if (mounted) {
         ref.invalidate(plansListProvider);
         context.pop();
      }
    } catch(e) {
      if(mounted) FeedbackService.showError(context, e.toString());
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _delete() async {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Delete Plan'), 
            content: const Text('Are you sure?'),
            actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
            ],
        ),
      );
      
      if (confirm == true) {
          try {
             await ref.read(plansRepositoryProvider).deletePlan(widget.planId!);
             if (mounted) {
                 ref.invalidate(plansListProvider);
                 context.pop();
             }
          } catch(e) {
              if (mounted) FeedbackService.showError(context, e.toString());
          }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.planId != null ? 'Edit Plan' : 'New Plan'),
          actions: [
              if (widget.planId != null)
                 IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: _delete)
          ],
      ),
      body: _isLoading && widget.planId != null
       ? const Center(child: CircularProgressIndicator())
       : SingleChildScrollView(
         padding: const EdgeInsets.all(16),
         child: Form(
           key: _formKey,
           child: Column(
             children: [
               TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Plan Name'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 16),
               TextFormField(controller: _codeController, decoration: const InputDecoration(labelText: 'Plan Code'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 16),
               Row(children: [
                   Expanded(child: TextFormField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number)),
                   const SizedBox(width: 16),
                   Expanded(child: DropdownButtonFormField<String>(
                     value: _cycle,
                     decoration: const InputDecoration(labelText: 'Cycle'),
                     items: ['monthly', 'annual'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                     onChanged: (v) => setState(() => _cycle = v!),
                   )),
               ]),
               const SizedBox(height: 16),
               Row(children: [
                   Expanded(child: TextFormField(controller: _seatsController, decoration: const InputDecoration(labelText: 'Seats Limit'), keyboardType: TextInputType.number)),
                   const SizedBox(width: 16),
                   Expanded(child: TextFormField(controller: _storageController, decoration: const InputDecoration(labelText: 'Storage (GB)'), keyboardType: TextInputType.number)),
               ]),
               const SizedBox(height: 32),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: Text('Save')),
             ],
           ),
         ),
       ),
    );
  }
}
