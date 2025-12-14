import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contracts_repository.dart';
import '../models/contract_model.dart';

class ContracforceContractDetailPage extends ConsumerWidget {
  final String id;
  const ContracforceContractDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(contracforceContractDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/contracforce/contracts/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<ContracforceContract>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('ContractorId'), subtitle: Text(item.contractorId.toString())),
              ListTile(title: Text('ContractNumber'), subtitle: Text(item.contractNumber.toString())),
              ListTile(title: Text('ContractType'), subtitle: Text(item.contractType.toString())),
              ListTile(title: Text('StartDate'), subtitle: Text(item.startDate.toString())),
              ListTile(title: Text('EndDate'), subtitle: Text(item.endDate.toString())),
              ListTile(title: Text('ScopeOfWork'), subtitle: Text(item.scopeOfWork.toString())),
              ListTile(title: Text('ContractValue'), subtitle: Text(item.contractValue.toString())),
              ListTile(title: Text('PaymentTerms'), subtitle: Text(item.paymentTerms.toString())),
              ListTile(title: Text('AutoRenew'), subtitle: Text(item.autoRenew.toString())),
              ListTile(title: Text('ContractFileId'), subtitle: Text(item.contractFileId.toString())),
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
            ],
          );
        },
      ),
    );
  }
}
