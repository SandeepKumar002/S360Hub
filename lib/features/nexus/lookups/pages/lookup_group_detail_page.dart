import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../../../core/widgets/common/log_history_widget.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/lookups_repository.dart';
import '../models/lookup_models.dart';

class LookupGroupDetailPage extends ConsumerWidget {
  final String groupId;
  const LookupGroupDetailPage({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupAsync = ref.watch(lookupGroupDetailProvider(groupId));
    final valuesAsync = ref.watch(lookupValuesListProvider(groupId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lookup Group'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/nexus/lookups/$groupId/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
               final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Group'),
                  content: const Text('Are you sure? This will delete all lookup values as well.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                  ],
                ),
              );

              if (confirm == true) {
                await ref.read(lookupsRepositoryProvider).deleteGroup(groupId);
                if (context.mounted) {
                  context.pop(); // Go back to dashboard
                }
              }
            },
          ),
        ],
      ),
      body: AsyncValueWidget<LookupGroup>(
        value: groupAsync,
        data: (group) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGroupHeader(context, group),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Values', style: Theme.of(context).textTheme.titleLarge),
                    IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.blue),
                        onPressed: () {
                           _showValueForm(context, ref, groupId, null);
                        },
                    ),
                  ],
                ),
                const Divider(),
                AsyncValueWidget<List<LookupValue>>(
                  value: valuesAsync,
                  data: (values) {
                    if (values.isEmpty) return const Text('No values found.');
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: values.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final value = values[index];
                        return ListTile(
                          title: Text(value.value),
                          subtitle: Text('Key: ${value.key} | Order: ${value.sortOrder}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 20),
                                onPressed: () => _showValueForm(context, ref, groupId, value),
                              ),
                               IconButton(
                                icon: const Icon(Icons.delete, size: 20, color: Colors.grey),
                                onPressed: () async {
                                  await ref.read(lookupsRepositoryProvider).deleteValue(value.id);
                                   ref.invalidate(lookupValuesListProvider(groupId));
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                 const SizedBox(height: 24),
                 LogHistoryWidget(tableName: 'nexus.lookup_groups', recordId: groupId),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGroupHeader(BuildContext context, LookupGroup group) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(group.displayName, style: Theme.of(context).textTheme.headlineSmall),
                Chip(
                    label: Text(group.isActive ? 'Active' : 'Inactive'),
                    backgroundColor: group.isActive ? Colors.green[100] : Colors.grey[200],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(alignment: Alignment.centerLeft, child: Text('Code: ${group.code}', style: const TextStyle(fontWeight: FontWeight.bold))),
            if (group.description != null) ...[
                 const SizedBox(height: 8),
                 Align(alignment: Alignment.centerLeft, child: Text(group.description!)),
            ],
          ],
        ),
      ),
    );
  }

  void _showValueForm(BuildContext context, WidgetRef ref, String groupId, LookupValue? value) {
     showDialog(
       context: context,
       builder: (context) => _LookupValueDialog(groupId: groupId, value: value),
     );
  }
}

class _LookupValueDialog extends ConsumerStatefulWidget {
  final String groupId;
  final LookupValue? value;
  const _LookupValueDialog({required this.groupId, this.value});

  @override
  ConsumerState<_LookupValueDialog> createState() => _LookupValueDialogState();
}

class _LookupValueDialogState extends ConsumerState<_LookupValueDialog> {
   final _keyController = TextEditingController();
   final _valueController = TextEditingController();
   final _orderController = TextEditingController();
   bool _isActive = true;

   @override
  void initState() {
    super.initState();
    if(widget.value != null) {
      _keyController.text = widget.value!.key;
      _valueController.text = widget.value!.value;
      _orderController.text = widget.value!.sortOrder.toString();
      _isActive = widget.value!.isActive;
    } else {
        _orderController.text = '0';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.value == null ? 'Add Value' : 'Edit Value'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _keyController, decoration: const InputDecoration(labelText: 'Key (Internal)')),
            TextField(controller: _valueController, decoration: const InputDecoration(labelText: 'Value (Display)')),
            TextField(controller: _orderController, decoration: const InputDecoration(labelText: 'Sort Order'), keyboardType: TextInputType.number),
             CheckboxListTile(
                 title: const Text('Is Active'),
                 value: _isActive,
                 onChanged: (v) => setState(() => _isActive = v ?? true),
             ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () async {
                final data = {
                    'group_id': widget.groupId,
                    'key': _keyController.text,
                    'value': _valueController.text,
                    'sort_order': int.tryParse(_orderController.text) ?? 0,
                    'is_active': _isActive,
                };
                
                try {
                    if (widget.value != null) {
                        await ref.read(lookupsRepositoryProvider).updateValue(widget.value!.id, data);
                    } else {
                        await ref.read(lookupsRepositoryProvider).createValue(data);
                    }
                    if (!context.mounted) return;
                    ref.invalidate(lookupValuesListProvider(widget.groupId));
                    Navigator.pop(context);
                } catch(e) {
                     if(context.mounted) FeedbackService.showError(context, e.toString());
                }
            },
            child: const Text('Save'),
        ),
      ],
    );
  }
}
