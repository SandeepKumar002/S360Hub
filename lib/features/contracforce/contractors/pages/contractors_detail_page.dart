import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contractors_repository.dart';
import '../models/contractor_model.dart';

class ContracforceContractorDetailPage extends ConsumerWidget {
  final String id;
  const ContracforceContractorDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(contracforceContractorDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/contracforce/contractors/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<ContracforceContractor>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('EntityId'), subtitle: Text(item.entityId.toString())),
              ListTile(title: Text('ContractorCode'), subtitle: Text(item.contractorCode.toString())),
              ListTile(title: Text('ContractorName'), subtitle: Text(item.contractorName.toString())),
              ListTile(title: Text('ContractorType'), subtitle: Text(item.contractorType.toString())),
              ListTile(title: Text('ContactPerson'), subtitle: Text(item.contactPerson.toString())),
              ListTile(title: Text('ContactNumber'), subtitle: Text(item.contactNumber.toString())),
              ListTile(title: Text('Email'), subtitle: Text(item.email.toString())),
              ListTile(title: Text('Address'), subtitle: Text(item.address.toString())),
              ListTile(title: Text('City'), subtitle: Text(item.city.toString())),
              ListTile(title: Text('State'), subtitle: Text(item.state.toString())),
              ListTile(title: Text('Pincode'), subtitle: Text(item.pincode.toString())),
              ListTile(title: Text('GstNumber'), subtitle: Text(item.gstNumber.toString())),
              ListTile(title: Text('PanNumber'), subtitle: Text(item.panNumber.toString())),
              ListTile(title: Text('BankName'), subtitle: Text(item.bankName.toString())),
              ListTile(title: Text('BankAccountNumberMasked'), subtitle: Text(item.bankAccountNumberMasked.toString())),
              ListTile(title: Text('IfscCode'), subtitle: Text(item.ifscCode.toString())),
              ListTile(title: Text('LicenseNumber'), subtitle: Text(item.licenseNumber.toString())),
              ListTile(title: Text('LicenseExpiryDate'), subtitle: Text(item.licenseExpiryDate.toString())),
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
