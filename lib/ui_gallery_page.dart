import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/services/feedback_service.dart';
import 'core/widgets/common/async_value_widget.dart';

class UiGalleryPage extends ConsumerWidget {
  const UiGalleryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI Gallery')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Semantic Colors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _colorBox('Success', Theme.of(context).extension<SemanticColors>()!.success!),
                _colorBox('Error', Theme.of(context).extension<SemanticColors>()!.error!),
                _colorBox('Warning', Theme.of(context).extension<SemanticColors>()!.warning!),
                _colorBox('Info', Theme.of(context).extension<SemanticColors>()!.info!),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Feedback', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => FeedbackService.showSuccess(context, 'Operation successful!'),
                  child: const Text('Success Toast'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => FeedbackService.showError(context, 'Network connection failed'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Error Toast'),
                ),
              ],
            ),
             const SizedBox(height: 24),
            const Text('Async Value (Simulated)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: AsyncValueWidget<String>(
                value: const AsyncValue.data('Loaded Data Successfully'),
                data: (data) => Center(child: Text(data, style: const TextStyle(color: Colors.green))),
                showLoadingShimmer: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorBox(String label, Color color) {
    return Column(
      children: [
        Container(width: 60, height: 60, color: color, margin: const EdgeInsets.only(bottom: 4)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
