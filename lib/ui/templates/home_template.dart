import 'package:flutter/material.dart';

import '../molecules/theme_toggle.dart';

class HomeTemplate extends StatelessWidget {
  const HomeTemplate({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
    required this.onAdd,
    required this.body,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final VoidCallback onAdd;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POCKET NOTES'),
        actions: [
          ThemeToggle(mode: themeMode, onToggle: onToggleTheme),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(child: body),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        tooltip: 'Add contact',
        child: const Icon(Icons.add),
      ),
    );
  }
}
