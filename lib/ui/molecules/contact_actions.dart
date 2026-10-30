import 'package:flutter/material.dart';

import '../atoms/app_icon_button.dart';

/// Edit and delete buttons, side by side.
class ContactActions extends StatelessWidget {
  const ContactActions({super.key, required this.onEdit, required this.onDelete});

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIconButton(icon: Icons.edit_outlined, tooltip: 'Edit', onPressed: onEdit),
        const SizedBox(width: 8),
        AppIconButton(
          icon: Icons.delete_outline,
          tooltip: 'Delete',
          onPressed: onDelete,
          danger: true,
        ),
      ],
    );
  }
}
