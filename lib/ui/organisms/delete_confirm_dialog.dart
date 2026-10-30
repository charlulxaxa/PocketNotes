import 'package:flutter/material.dart';

import '../../core/app_theme.dart';
import '../../data/contact.dart';

class DeleteConfirmDialog extends StatelessWidget {
  const DeleteConfirmDialog({super.key, required this.contact});

  final Contact contact;

  /// Resolves to true only if the user confirms.
  static Future<bool> show(BuildContext context, Contact contact) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => DeleteConfirmDialog(contact: contact),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final danger = Theme.of(context).extension<DangerColor>()!.color;
    return AlertDialog(
      title: const Text('Delete contact?'),
      content: Text('${contact.name} will be removed permanently.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: danger),
          child: const Text('Delete', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
