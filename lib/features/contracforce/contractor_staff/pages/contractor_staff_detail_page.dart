import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/contractor_staff_repository.dart';
import '../models/contractor_staff_model.dart';

class ContracforceContractorStaffDetailPage extends ConsumerWidget {
  final String id;
  const ContracforceContractorStaffDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(contracforceContractorStaffDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/contracforce/contractor-staff/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<ContracforceContractorStaff>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('ContractorId'), subtitle: Text(item.contractorId.toString())),
              ListTile(title: Text('StaffCode'), subtitle: Text(item.staffCode.toString())),
              ListTile(title: Text('FullName'), subtitle: Text(item.fullName.toString())),
              ListTile(title: Text('FatherName'), subtitle: Text(item.fatherName.toString())),
              ListTile(title: Text('DateOfBirth'), subtitle: Text(item.dateOfBirth.toString())),
              ListTile(title: Text('Gender'), subtitle: Text(item.gender.toString())),
              ListTile(title: Text('Mobile'), subtitle: Text(item.mobile.toString())),
              ListTile(title: Text('Address'), subtitle: Text(item.address.toString())),
              ListTile(title: Text('StaffType'), subtitle: Text(item.staffType.toString())),
              ListTile(title: Text('JoiningDate'), subtitle: Text(item.joiningDate.toString())),
              ListTile(title: Text('LeavingDate'), subtitle: Text(item.leavingDate.toString())),
              ListTile(title: Text('AadhaarNumberMasked'), subtitle: Text(item.aadhaarNumberMasked.toString())),
              ListTile(title: Text('BankAccountNumberMasked'), subtitle: Text(item.bankAccountNumberMasked.toString())),
              ListTile(title: Text('IfscCode'), subtitle: Text(item.ifscCode.toString())),
              ListTile(title: Text('UanNumber'), subtitle: Text(item.uanNumber.toString())),
              ListTile(title: Text('EsiNumber'), subtitle: Text(item.esiNumber.toString())),
              ListTile(title: Text('WagePerDay'), subtitle: Text(item.wagePerDay.toString())),
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
