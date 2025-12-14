import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/active_prospects_repository.dart';
import '../models/active_prospect_model.dart';

class LedgieActiveProspectDetailPage extends ConsumerWidget {
  final String id;
  const LedgieActiveProspectDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(ledgieActiveProspectDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/ledgie/active-prospects/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<LedgieActiveProspect>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('EntityCode'), subtitle: Text(item.entityCode.toString())),
              ListTile(title: Text('CompanyName'), subtitle: Text(item.companyName.toString())),
              ListTile(title: Text('EntityStatus'), subtitle: Text(item.entityStatus.toString())),
              ListTile(title: Text('LeadTemperature'), subtitle: Text(item.leadTemperature.toString())),
              ListTile(title: Text('LeadPriority'), subtitle: Text(item.leadPriority.toString())),
              ListTile(title: Text('LeadSource'), subtitle: Text(item.leadSource.toString())),
              ListTile(title: Text('EstimatedValue'), subtitle: Text(item.estimatedValue.toString())),
              ListTile(title: Text('NextFollowUpDate'), subtitle: Text(item.nextFollowUpDate.toString())),
              ListTile(title: Text('LastContactDate'), subtitle: Text(item.lastContactDate.toString())),
              ListTile(title: Text('InteractionCount'), subtitle: Text(item.interactionCount.toString())),
              ListTile(title: Text('AssignedTo'), subtitle: Text(item.assignedTo.toString())),
              ListTile(title: Text('AssignedToName'), subtitle: Text(item.assignedToName.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
            ],
          );
        },
      ),
    );
  }
}
