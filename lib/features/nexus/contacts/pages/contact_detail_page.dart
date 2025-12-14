import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../../../core/widgets/common/log_history_widget.dart';
import '../repositories/contacts_repository.dart';
import '../models/contact_models.dart';

class ContactDetailPage extends ConsumerWidget {
  final String contactId;
  const ContactDetailPage({super.key, required this.contactId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactAsync = ref.watch(contactDetailProvider(contactId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/nexus/contacts/$contactId/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
             onPressed: () async {
               final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Contact'),
                  content: const Text('Are you sure?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                  ],
                ),
              );

              if (confirm == true) {
                await ref.read(contactsRepositoryProvider).deleteContact(contactId);
                if (context.mounted) {
                  context.pop();
                }
              }
            },
          ),
        ],
      ),
      body: AsyncValueWidget<Contact>(
        value: contactAsync,
        data: (contact) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contact.name ?? 'Unknown', style: Theme.of(context).textTheme.headlineSmall),
                        if (contact.designation != null) Text(contact.designation!),
                        const Divider(),
                        _buildInfoRow(Icons.phone, contact.phone),
                        _buildInfoRow(Icons.email, contact.email),
                        _buildInfoRow(Icons.category, contact.contactType),
                        _buildInfoRow(Icons.location_on, contact.locationGps),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                LogHistoryWidget(tableName: 'nexus.contacts', recordId: contactId),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}
