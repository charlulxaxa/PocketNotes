import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'core/theme_store.dart';
import 'ui/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load the saved theme BEFORE the first frame so nothing flashes.
  final savedMode = await ThemeStore.load();
  runApp(PocketNotesApp(initialMode: savedMode));
}

class PocketNotesApp extends StatefulWidget {
  const PocketNotesApp({super.key, required this.initialMode});

  final ThemeMode initialMode;

  @override
  State<PocketNotesApp> createState() => _PocketNotesAppState();
}

class _PocketNotesAppState extends State<PocketNotesApp> {
  late ThemeMode _mode = widget.initialMode;

  void _toggleTheme() {
    final next = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setState(() => _mode = next);
    ThemeStore.save(next);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POCKET NOTES',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _mode,
      home: HomePage(themeMode: _mode, onToggleTheme: _toggleTheme),
    );
  }
}
