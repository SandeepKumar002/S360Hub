import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/safety_incidents_repository.dart';
import '../models/safety_incident_model.dart';

class ShieldSafetyIncidentDetailPage extends ConsumerWidget {
  final String id;
  const ShieldSafetyIncidentDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(shieldSafetyIncidentDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/shield/safety-incidents/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<ShieldSafetyIncident>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('IncidentId'), subtitle: Text(item.incidentId.toString())),
              ListTile(title: Text('IncidentDate'), subtitle: Text(item.incidentDate.toString())),
              ListTile(title: Text('Location'), subtitle: Text(item.location.toString())),
              ListTile(title: Text('LocationGps'), subtitle: Text(item.locationGps.toString())),
              ListTile(title: Text('Severity'), subtitle: Text(item.severity.toString())),
              ListTile(title: Text('Description'), subtitle: Text(item.description.toString())),
              ListTile(title: Text('InjuriesReported'), subtitle: Text(item.injuriesReported.toString())),
              ListTile(title: Text('InjuredPersons'), subtitle: Text(item.injuredPersons.toString())),
              ListTile(title: Text('ImmediateActionTaken'), subtitle: Text(item.immediateActionTaken.toString())),
              ListTile(title: Text('InvestigationRequired'), subtitle: Text(item.investigationRequired.toString())),
              ListTile(title: Text('InvestigationFileId'), subtitle: Text(item.investigationFileId.toString())),
              ListTile(title: Text('PreventiveMeasures'), subtitle: Text(item.preventiveMeasures.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
              ListTile(title: Text('ReportedBy'), subtitle: Text(item.reportedBy.toString())),
              ListTile(title: Text('AssignedTo'), subtitle: Text(item.assignedTo.toString())),
              ListTile(title: Text('Metadata'), subtitle: Text(item.metadata.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
              ListTile(title: Text('CreatedBy'), subtitle: Text(item.createdBy.toString())),
              ListTile(title: Text('UpdatedAt'), subtitle: Text(item.updatedAt.toString())),
              ListTile(title: Text('UpdatedBy'), subtitle: Text(item.updatedBy.toString())),
              ListTile(title: Text('ApprovedAt'), subtitle: Text(item.approvedAt.toString())),
              ListTile(title: Text('ApprovedBy'), subtitle: Text(item.approvedBy.toString())),
              ListTile(title: Text('DeletedAt'), subtitle: Text(item.deletedAt.toString())),
              ListTile(title: Text('DeletedBy'), subtitle: Text(item.deletedBy.toString())),
              ListTile(title: Text('DeleteType'), subtitle: Text(item.deleteType.toString())),
              ListTile(title: Text('IsDeleted'), subtitle: Text(item.isDeleted.toString())),
            ],
          );
        },
      ),
    );
  }
}
