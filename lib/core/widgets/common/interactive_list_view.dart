import 'package:flutter/material.dart';

class InteractiveListView<T> extends StatelessWidget {
  final List<T> data;
  final Widget Function(BuildContext, T) itemBuilder;
  final Future<void> Function() onRefresh;
  final String emptyMessage;

  const InteractiveListView({
    super.key,
    required this.data,
    required this.itemBuilder,
    required this.onRefresh,
    this.emptyMessage = 'No data available',
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(color: Colors.grey[500], fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () => onRefresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: Theme.of(context).primaryColor,
      backgroundColor: Colors.white,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: data.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => itemBuilder(context, data[index]),
      ),
    );
  }
}
