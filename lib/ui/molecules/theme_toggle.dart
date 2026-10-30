import 'package:flutter/material.dart';

/// Sun icon, switch, moon icon. The switch is ON in dark mode.
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key, required this.mode, required this.onToggle});

  final ThemeMode mode;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = mode == ThemeMode.dark;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.light_mode_outlined,
          size: 20,
          color: isDark ? scheme.onSurfaceVariant : scheme.primary,
        ),
        Semantics(
          label: 'Dark mode',
          toggled: isDark,
          child: Switch(
            value: isDark,
            onChanged: (_) => onToggle(),
          ),
        ),
        Icon(
          Icons.dark_mode_outlined,
          size: 20,
          color: isDark ? scheme.primary : scheme.onSurfaceVariant,
        ),
      ],
    );
  }
}
