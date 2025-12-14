import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FeedbackService {
  static void showSuccess(BuildContext context, String message) {
    _showToast(context, message, isError: false);
  }

  static void showError(BuildContext context, String message) {
    _showToast(context, message, isError: true);
  }

  static void _showToast(BuildContext context, String message, {required bool isError}) {
    final semantic = Theme.of(context).extension<SemanticColors>();
    final color = isError ? (semantic?.error ?? Colors.red) : (semantic?.success ?? Colors.green);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(isError ? Icons.error_outline : Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
