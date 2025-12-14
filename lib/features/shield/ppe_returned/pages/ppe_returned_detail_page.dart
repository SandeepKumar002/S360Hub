import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/ppe_returned_repository.dart';
import '../models/ppe_returned_model.dart';

class ShieldPpeReturnedDetailPage extends ConsumerWidget {
  final String id;
  const ShieldPpeReturnedDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(shieldPpeReturnedDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/shield/ppe-returned/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<ShieldPpeReturned>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('PpeIssuedId'), subtitle: Text(item.ppeIssuedId.toString())),
              ListTile(title: Text('ReturnDate'), subtitle: Text(item.returnDate.toString())),
              ListTile(title: Text('QuantityReturned'), subtitle: Text(item.quantityReturned.toString())),
              ListTile(title: Text('Condition'), subtitle: Text(item.condition.toString())),
              ListTile(title: Text('ReturnedTo'), subtitle: Text(item.returnedTo.toString())),
              ListTile(title: Text('Remarks'), subtitle: Text(item.remarks.toString())),
              ListTile(title: Text('Metadata'), subtitle: Text(item.metadata.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
              ListTile(title: Text('CreatedBy'), subtitle: Text(item.createdBy.toString())),
            ],
          );
        },
      ),
    );
  }
}
