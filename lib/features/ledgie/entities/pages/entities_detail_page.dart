import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/entities_repository.dart';
import '../models/entitie_model.dart';

class LedgieEntitieDetailPage extends ConsumerWidget {
  final String id;
  const LedgieEntitieDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(ledgieEntitieDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/ledgie/entities/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<LedgieEntitie>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('EntityCode'), subtitle: Text(item.entityCode.toString())),
              ListTile(title: Text('Name'), subtitle: Text(item.name.toString())),
              ListTile(title: Text('Type'), subtitle: Text(item.type.toString())),
              ListTile(title: Text('PrimaryContactId'), subtitle: Text(item.primaryContactId.toString())),
              ListTile(title: Text('Country'), subtitle: Text(item.country.toString())),
              ListTile(title: Text('State'), subtitle: Text(item.state.toString())),
              ListTile(title: Text('District'), subtitle: Text(item.district.toString())),
              ListTile(title: Text('Pincode'), subtitle: Text(item.pincode.toString())),
              ListTile(title: Text('GstDefaultId'), subtitle: Text(item.gstDefaultId.toString())),
              ListTile(title: Text('Pan'), subtitle: Text(item.pan.toString())),
              ListTile(title: Text('Website'), subtitle: Text(item.website.toString())),
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
              ListTile(title: Text('EntityStatus'), subtitle: Text(item.entityStatus.toString())),
              ListTile(title: Text('LeadSource'), subtitle: Text(item.leadSource.toString())),
              ListTile(title: Text('LeadTemperature'), subtitle: Text(item.leadTemperature.toString())),
              ListTile(title: Text('LeadPriority'), subtitle: Text(item.leadPriority.toString())),
              ListTile(title: Text('AssignedTo'), subtitle: Text(item.assignedTo.toString())),
              ListTile(title: Text('FirstContactDate'), subtitle: Text(item.firstContactDate.toString())),
              ListTile(title: Text('LastContactDate'), subtitle: Text(item.lastContactDate.toString())),
              ListTile(title: Text('NextFollowUpDate'), subtitle: Text(item.nextFollowUpDate.toString())),
              ListTile(title: Text('EstimatedValue'), subtitle: Text(item.estimatedValue.toString())),
              ListTile(title: Text('ExpectedCloseDate'), subtitle: Text(item.expectedCloseDate.toString())),
              ListTile(title: Text('ConvertedDate'), subtitle: Text(item.convertedDate.toString())),
              ListTile(title: Text('InteractionCount'), subtitle: Text(item.interactionCount.toString())),
              ListTile(title: Text('Notes'), subtitle: Text(item.notes.toString())),
            ],
          );
        },
      ),
    );
  }
}
