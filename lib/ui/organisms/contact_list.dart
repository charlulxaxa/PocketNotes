import 'package:flutter/material.dart';

import '../../data/contact.dart';
import '../molecules/empty_state.dart';
import 'contact_card.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    super.key,
    required this.contacts,
    required this.onEdit,
    required this.onDelete,
  });

  final List<Contact> contacts;
  final ValueChanged<Contact> onEdit;
  final ValueChanged<Contact> onDelete;

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) return const EmptyState();
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      itemCount: contacts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final c = contacts[i];
        return ContactCard(
          key: ValueKey(c.id),
          contact: c,
          onEdit: () => onEdit(c),
          onDelete: () => onDelete(c),
        );
      },
    );
  }
}
