import 'package:flutter/material.dart';

import '../../data/contact.dart';
import '../../data/contact_database.dart';
import '../atoms/error_snackbar.dart';
import '../molecules/search_field.dart';
import '../organisms/contact_form_sheet.dart';
import '../organisms/contact_list.dart';
import '../organisms/delete_confirm_dialog.dart';
import '../templates/home_template.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> _contacts = [];
  bool _loading = true;

  // Plain State only. Never saved, so it resets on every restart.
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Contact> get _visible {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _contacts;
    return _contacts
        .where((c) => c.name.toLowerCase().contains(q) || c.phone.contains(q))
        .toList();
  }

  Future<void> _load() async {
    try {
      final contacts = await ContactDatabase.all();
      if (!mounted) return;
      setState(() {
        _contacts = contacts;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
      ErrorSnackbar.show(context, "Couldn't load contacts.");
    }
  }

  Future<void> _openForm({Contact? contact}) async {
    final result = await ContactFormSheet.show(context, contact: contact);
    if (result == null) return;
    try {
      if (contact == null) {
        await ContactDatabase.insert(result);
      } else {
        await ContactDatabase.update(result);
      }
      await _load();
    } catch (_) {
      if (mounted) ErrorSnackbar.show(context, "Couldn't save contact. Please try again.");
    }
  }

  Future<void> _confirmDelete(Contact contact) async {
    final confirmed = await DeleteConfirmDialog.show(context, contact);
    if (!confirmed || contact.id == null) return;
    try {
      await ContactDatabase.delete(contact.id!);
      await _load();
    } catch (_) {
      if (mounted) ErrorSnackbar.show(context, "Couldn't delete contact. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeTemplate(
      themeMode: widget.themeMode,
      onToggleTheme: widget.onToggleTheme,
      onAdd: () => _openForm(),
      body: _loading ? const SizedBox.shrink() : _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_contacts.isEmpty) {
      return ContactList(
        contacts: _contacts,
        onEdit: (c) => _openForm(contact: c),
        onDelete: _confirmDelete,
      );
    }
    final visible = _visible;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: SearchField(
            controller: _searchController,
            onChanged: (value) => setState(() => _query = value),
            onClear: () {
              _searchController.clear();
              setState(() => _query = '');
            },
          ),
        ),
        Expanded(
          child: visible.isEmpty
              ? Center(
                  child: Text(
                    'No matches',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                )
              : ContactList(
                  contacts: visible,
                  onEdit: (c) => _openForm(contact: c),
                  onDelete: _confirmDelete,
                ),
        ),
      ],
    );
  }
}
