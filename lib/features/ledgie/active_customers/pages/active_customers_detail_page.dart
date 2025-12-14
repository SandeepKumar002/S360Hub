import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/active_customers_repository.dart';
import '../models/active_customer_model.dart';

class LedgieActiveCustomerDetailPage extends ConsumerWidget {
  final String id;
  const LedgieActiveCustomerDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(ledgieActiveCustomerDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/ledgie/active-customers/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<LedgieActiveCustomer>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('EntityCode'), subtitle: Text(item.entityCode.toString())),
              ListTile(title: Text('Name'), subtitle: Text(item.name.toString())),
              ListTile(title: Text('Type'), subtitle: Text(item.type.toString())),
              ListTile(title: Text('EntityStatus'), subtitle: Text(item.entityStatus.toString())),
              ListTile(title: Text('Country'), subtitle: Text(item.country.toString())),
              ListTile(title: Text('State'), subtitle: Text(item.state.toString())),
              ListTile(title: Text('Pan'), subtitle: Text(item.pan.toString())),
              ListTile(title: Text('Website'), subtitle: Text(item.website.toString())),
              ListTile(title: Text('AssignedTo'), subtitle: Text(item.assignedTo.toString())),
              ListTile(title: Text('AssignedToName'), subtitle: Text(item.assignedToName.toString())),
              ListTile(title: Text('ConvertedDate'), subtitle: Text(item.convertedDate.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
            ],
          );
        },
      ),
    );
  }
}
