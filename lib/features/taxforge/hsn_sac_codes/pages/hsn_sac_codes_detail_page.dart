import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/hsn_sac_codes_repository.dart';
import '../models/hsn_sac_code_model.dart';

class TaxforgeHsnSacCodeDetailPage extends ConsumerWidget {
  final String id;
  const TaxforgeHsnSacCodeDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(taxforgeHsnSacCodeDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/taxforge/hsn-sac-codes/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<TaxforgeHsnSacCode>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('Code'), subtitle: Text(item.code.toString())),
              ListTile(title: Text('Type'), subtitle: Text(item.type.toString())),
              ListTile(title: Text('Description'), subtitle: Text(item.description.toString())),
              ListTile(title: Text('DefaultGstRate'), subtitle: Text(item.defaultGstRate.toString())),
              ListTile(title: Text('DefaultGstType'), subtitle: Text(item.defaultGstType.toString())),
              ListTile(title: Text('UnitOfMeasure'), subtitle: Text(item.unitOfMeasure.toString())),
              ListTile(title: Text('IsExempt'), subtitle: Text(item.isExempt.toString())),
              ListTile(title: Text('ItcEligible'), subtitle: Text(item.itcEligible.toString())),
              ListTile(title: Text('AccountingCode'), subtitle: Text(item.accountingCode.toString())),
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
