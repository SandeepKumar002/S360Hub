import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/bank_accounts_repository.dart';
import '../models/bank_account_model.dart';

class FinacBankAccountDetailPage extends ConsumerWidget {
  final String id;
  const FinacBankAccountDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(finacBankAccountDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/finac/bank-accounts/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<FinacBankAccount>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('PartyType'), subtitle: Text(item.partyType.toString())),
              ListTile(title: Text('PartyId'), subtitle: Text(item.partyId.toString())),
              ListTile(title: Text('AccountHolderName'), subtitle: Text(item.accountHolderName.toString())),
              ListTile(title: Text('BankName'), subtitle: Text(item.bankName.toString())),
              ListTile(title: Text('BranchName'), subtitle: Text(item.branchName.toString())),
              ListTile(title: Text('AccountNumberMasked'), subtitle: Text(item.accountNumberMasked.toString())),
              ListTile(title: Text('AccountNumberEncrypted'), subtitle: Text(item.accountNumberEncrypted.toString())),
              ListTile(title: Text('IfscCode'), subtitle: Text(item.ifscCode.toString())),
              ListTile(title: Text('SwiftCode'), subtitle: Text(item.swiftCode.toString())),
              ListTile(title: Text('AccountType'), subtitle: Text(item.accountType.toString())),
              ListTile(title: Text('Currency'), subtitle: Text(item.currency.toString())),
              ListTile(title: Text('OpeningBalance'), subtitle: Text(item.openingBalance.toString())),
              ListTile(title: Text('CurrentBalance'), subtitle: Text(item.currentBalance.toString())),
              ListTile(title: Text('IsDefault'), subtitle: Text(item.isDefault.toString())),
              ListTile(title: Text('Verified'), subtitle: Text(item.verified.toString())),
              ListTile(title: Text('KycDocuments'), subtitle: Text(item.kycDocuments.toString())),
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
