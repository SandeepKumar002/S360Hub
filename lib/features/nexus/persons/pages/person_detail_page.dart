import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../../../core/widgets/common/log_history_widget.dart';
import '../repositories/persons_repository.dart';
import '../models/person_model.dart'; 

class PersonDetailPage extends ConsumerWidget {
  final String personId;
  const PersonDetailPage({super.key, required this.personId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personAsync = ref.watch(personDetailProvider(personId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
               // Navigation to Edit Page (placeholder)
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit not implemented yet')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              // Confirm Dialog
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Person'),
                  content: const Text('Are you sure you want to delete this person?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                  ],
                ),
              );

              if (confirm == true) {
                await ref.read(personsRepositoryProvider).deletePerson(personId);
                if (context.mounted) {
                  context.pop();
                }
              }
            },
          ),
        ],
      ),
      body: AsyncValueWidget<Person>(
        value: personAsync,
        data: (person) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, person),
                const SizedBox(height: 24),
                _buildInfoSection(context, person),
                const SizedBox(height: 24),
                LogHistoryWidget(tableName: 'nexus.persons', recordId: personId),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Person person) {
    return Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            person.firstName.substring(0, 1).toUpperCase(),
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              person.displayName ?? 'Unknown Person',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (person.email != null)
              Text(
                person.email!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
          ],
        ),
        const Spacer(),
        if (person.isOrgAdmin)
          const Chip(label: Text('Admin'), backgroundColor: Colors.amber, labelStyle: TextStyle(color: Colors.black)),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context, Person person) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow('First Name', person.firstName),
            const Divider(),
            _buildInfoRow('Last Name', person.lastName),
            const Divider(),
            _buildInfoRow('Phone', person.phone ?? '-'),
            const Divider(),
            _buildInfoRow('Org ID', person.orgId ?? '-'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }
}
