import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/bank_transactions_repository.dart';
import '../models/bank_transaction_model.dart';

class FinacBankTransactionDetailPage extends ConsumerWidget {
  final String id;
  const FinacBankTransactionDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(finacBankTransactionDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/finac/bank-transactions/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<FinacBankTransaction>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('TransactionNumber'), subtitle: Text(item.transactionNumber.toString())),
              ListTile(title: Text('BankAccountId'), subtitle: Text(item.bankAccountId.toString())),
              ListTile(title: Text('TxnDate'), subtitle: Text(item.txnDate.toString())),
              ListTile(title: Text('Amount'), subtitle: Text(item.amount.toString())),
              ListTile(title: Text('Currency'), subtitle: Text(item.currency.toString())),
              ListTile(title: Text('CurrencyRate'), subtitle: Text(item.currencyRate.toString())),
              ListTile(title: Text('Direction'), subtitle: Text(item.direction.toString())),
              ListTile(title: Text('TransactionPurpose'), subtitle: Text(item.transactionPurpose.toString())),
              ListTile(title: Text('PartyType'), subtitle: Text(item.partyType.toString())),
              ListTile(title: Text('PartyId'), subtitle: Text(item.partyId.toString())),
              ListTile(title: Text('ReferenceTable'), subtitle: Text(item.referenceTable.toString())),
              ListTile(title: Text('ReferenceId'), subtitle: Text(item.referenceId.toString())),
              ListTile(title: Text('BankReference'), subtitle: Text(item.bankReference.toString())),
              ListTile(title: Text('ChequeNumber'), subtitle: Text(item.chequeNumber.toString())),
              ListTile(title: Text('UtrNumber'), subtitle: Text(item.utrNumber.toString())),
              ListTile(title: Text('Status'), subtitle: Text(item.status.toString())),
              ListTile(title: Text('ClearedAt'), subtitle: Text(item.clearedAt.toString())),
              ListTile(title: Text('ReconciliationStatus'), subtitle: Text(item.reconciliationStatus.toString())),
              ListTile(title: Text('ReconciledAt'), subtitle: Text(item.reconciledAt.toString())),
              ListTile(title: Text('ReconciledBy'), subtitle: Text(item.reconciledBy.toString())),
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
