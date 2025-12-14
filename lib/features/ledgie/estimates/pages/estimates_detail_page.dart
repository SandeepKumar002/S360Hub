import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/estimates_repository.dart';
import '../models/estimate_model.dart';

class LedgieEstimateDetailPage extends ConsumerWidget {
  final String id;
  const LedgieEstimateDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(ledgieEstimateDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/ledgie/estimates/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<LedgieEstimate>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('ProposalId'), subtitle: Text(item.proposalId.toString())),
              ListTile(title: Text('EstimateNumber'), subtitle: Text(item.estimateNumber.toString())),
              ListTile(title: Text('EstimateDate'), subtitle: Text(item.estimateDate.toString())),
              ListTile(title: Text('EntityId'), subtitle: Text(item.entityId.toString())),
              ListTile(title: Text('EntityCode'), subtitle: Text(item.entityCode.toString())),
              ListTile(title: Text('EntityName'), subtitle: Text(item.entityName.toString())),
              ListTile(title: Text('EntityContactName'), subtitle: Text(item.entityContactName.toString())),
              ListTile(title: Text('Country'), subtitle: Text(item.country.toString())),
              ListTile(title: Text('State'), subtitle: Text(item.state.toString())),
              ListTile(title: Text('District'), subtitle: Text(item.district.toString())),
              ListTile(title: Text('SubDistrict'), subtitle: Text(item.subDistrict.toString())),
              ListTile(title: Text('Address'), subtitle: Text(item.address.toString())),
              ListTile(title: Text('Pincode'), subtitle: Text(item.pincode.toString())),
              ListTile(title: Text('Gstin'), subtitle: Text(item.gstin.toString())),
              ListTile(title: Text('Pan'), subtitle: Text(item.pan.toString())),
              ListTile(title: Text('StartDate'), subtitle: Text(item.startDate.toString())),
              ListTile(title: Text('EndDate'), subtitle: Text(item.endDate.toString())),
              ListTile(title: Text('Sector'), subtitle: Text(item.sector.toString())),
              ListTile(title: Text('HsnSacCodes'), subtitle: Text(item.hsnSacCodes.toString())),
              ListTile(title: Text('ServiceType'), subtitle: Text(item.serviceType.toString())),
              ListTile(title: Text('QuoteValidityDays'), subtitle: Text(item.quoteValidityDays.toString())),
              ListTile(title: Text('ServiceDescription'), subtitle: Text(item.serviceDescription.toString())),
              ListTile(title: Text('NumberOfUnits'), subtitle: Text(item.numberOfUnits.toString())),
              ListTile(title: Text('Currency'), subtitle: Text(item.currency.toString())),
              ListTile(title: Text('EstimatedCosts'), subtitle: Text(item.estimatedCosts.toString())),
              ListTile(title: Text('PaymentRetainerPct'), subtitle: Text(item.paymentRetainerPct.toString())),
              ListTile(title: Text('RetainerValue'), subtitle: Text(item.retainerValue.toString())),
              ListTile(title: Text('BalancePct'), subtitle: Text(item.balancePct.toString())),
              ListTile(title: Text('BalanceValue'), subtitle: Text(item.balanceValue.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
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
              ListTile(title: Text('LeadsProspectId'), subtitle: Text(item.leadsProspectId.toString())),
            ],
          );
        },
      ),
    );
  }
}
