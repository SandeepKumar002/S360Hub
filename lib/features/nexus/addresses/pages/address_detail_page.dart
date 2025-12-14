import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../../../core/widgets/common/log_history_widget.dart';
import '../repositories/addresses_repository.dart';
import '../models/address_models.dart';

class AddressDetailPage extends ConsumerWidget {
  final String addressId;
  const AddressDetailPage({super.key, required this.addressId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressAsync = ref.watch(addressDetailProvider(addressId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/nexus/addresses/$addressId/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
             onPressed: () async {
               final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Address'),
                  content: const Text('Are you sure?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                  ],
                ),
              );

              if (confirm == true) {
                await ref.read(addressesRepositoryProvider).deleteAddress(addressId);
                if (context.mounted) {
                  context.pop();
                }
              }
            },
          ),
        ],
      ),
      body: AsyncValueWidget<Address>(
        value: addressAsync,
        data: (address) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address Type: ${address.addressType ?? "N/A"}', style: Theme.of(context).textTheme.titleMedium),
                        const Divider(),
                        Text(address.line1 ?? ''),
                        if (address.line2 != null && address.line2!.isNotEmpty) Text(address.line2!),
                        Text('${address.city ?? ""}, ${address.state ?? ""} ${address.pincode ?? ""}'),
                        Text(address.country ?? ''),
                        const SizedBox(height: 16),
                        if (address.isDefault)
                          const Chip(label: Text('Default Address'), backgroundColor: Colors.greenAccent),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                LogHistoryWidget(tableName: 'nexus.addresses', recordId: addressId),
              ],
            ),
          );
        },
      ),
    );
  }
}
