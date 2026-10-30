import 'package:flutter/material.dart';

/// Red floating message for errors. Red is only used for delete and errors.
class ErrorSnackbar {
  ErrorSnackbar._();

  static void show(BuildContext context, String message) {
    final scheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: scheme.error,
          content: Row(
            children: [
              Icon(Icons.error_outline, color: scheme.onError, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(message, style: TextStyle(color: scheme.onError)),
              ),
            ],
          ),
        ),
      );
  }
}
