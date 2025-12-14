import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/tds_details_repository.dart';
import '../models/tds_detail_model.dart';

class TaxforgeTdsDetailDetailPage extends ConsumerWidget {
  final String id;
  const TaxforgeTdsDetailDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(taxforgeTdsDetailDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/taxforge/tds-details/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<TaxforgeTdsDetail>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('PartyType'), subtitle: Text(item.partyType.toString())),
              ListTile(title: Text('PartyId'), subtitle: Text(item.partyId.toString())),
              ListTile(title: Text('SectionCode'), subtitle: Text(item.sectionCode.toString())),
              ListTile(title: Text('TdsRatePercent'), subtitle: Text(item.tdsRatePercent.toString())),
              ListTile(title: Text('ThresholdAmount'), subtitle: Text(item.thresholdAmount.toString())),
              ListTile(title: Text('Pan'), subtitle: Text(item.pan.toString())),
              ListTile(title: Text('PanValidated'), subtitle: Text(item.panValidated.toString())),
              ListTile(title: Text('ExemptionCertificate'), subtitle: Text(item.exemptionCertificate.toString())),
              ListTile(title: Text('EffectiveFrom'), subtitle: Text(item.effectiveFrom.toString())),
              ListTile(title: Text('EffectiveTo'), subtitle: Text(item.effectiveTo.toString())),
              ListTile(title: Text('IsActive'), subtitle: Text(item.isActive.toString())),
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
