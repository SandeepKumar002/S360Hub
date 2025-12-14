import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../../../core/widgets/common/log_history_widget.dart';
import '../repositories/organizations_repository.dart';
import '../models/organization_model.dart';

class OrganizationDetailPage extends ConsumerWidget {
  final String orgId;
  const OrganizationDetailPage({super.key, required this.orgId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgAsync = ref.watch(organizationDetailProvider(orgId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/pulse/organizations/$orgId/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
               final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Organization'),
                  content: const Text('Are you sure? This action is critical.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                  ],
                ),
              );

              if (confirm == true) {
                await ref.read(organizationsRepositoryProvider).deleteOrganization(orgId);
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: AsyncValueWidget<Organization>(
        value: orgAsync,
        data: (org) {
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
                        Text(org.name, style: Theme.of(context).textTheme.headlineSmall),
                        Text('Code: ${org.code}'),
                        if (org.domain != null) Text('Domain: ${org.domain}'),
                        const Divider(),
                        _buildInfoRow('Status', org.status ?? '-'),
                        _buildInfoRow('Plan', org.planId ?? 'No Plan'),
                        _buildInfoRow('Capacity', '${org.activeUserCount} / ${org.userCapacity}'),
                        _buildInfoRow('Start Date', org.subscriptionStartDate?.toString().split(' ')[0] ?? '-'),
                        _buildInfoRow('End Date', org.subscriptionEndDate?.toString().split(' ')[0] ?? '-'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                LogHistoryWidget(tableName: 'pulse.organizations', recordId: orgId),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
