import 'package:flutter/material.dart';

import '../../data/contact.dart';
import '../atoms/app_text_field.dart';

/// One form for add and edit. Pass [contact] to edit, null to add.
/// Pops with the validated [Contact], or null if dismissed.
class ContactFormSheet extends StatefulWidget {
  const ContactFormSheet({super.key, this.contact});

  final Contact? contact;

  static Future<Contact?> show(BuildContext context, {Contact? contact}) {
    return showModalBottomSheet<Contact>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ContactFormSheet(contact: contact),
    );
  }

  @override
  State<ContactFormSheet> createState() => _ContactFormSheetState();
}

class _ContactFormSheetState extends State<ContactFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _phone;

  bool get _isEdit => widget.contact != null;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.contact?.name ?? '');
    _phone = TextEditingController(text: widget.contact?.phone ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  String? _required(String? value, String label) =>
      (value == null || value.trim().isEmpty) ? '$label cannot be empty' : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(Contact(
      id: widget.contact?.id,
      name: _name.text.trim(),
      phone: _phone.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        4,
        20,
        20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_isEdit ? 'Edit contact' : 'New contact',
                style: text.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 18),
            AppTextField(
              controller: _name,
              label: 'Name',
              icon: Icons.person_outline,
              autofocus: true,
              textInputAction: TextInputAction.next,
              validator: (v) => _required(v, 'Name'),
            ),
            const SizedBox(height: 14),
            AppTextField(
              controller: _phone,
              label: 'Phone number',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              validator: (v) => _required(v, 'Phone number'),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _submit,
              child: Text(_isEdit ? 'Save changes' : 'Add contact'),
            ),
          ],
        ),
      ),
    );
  }
}
