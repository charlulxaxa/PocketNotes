import 'package:flutter/material.dart';

/// Red lives here and is only read by the delete button and dialog action.
class DangerColor extends ThemeExtension<DangerColor> {
  const DangerColor(this.color);
  final Color color;

  @override
  DangerColor copyWith({Color? color}) => DangerColor(color ?? this.color);

  @override
  DangerColor lerp(ThemeExtension<DangerColor>? other, double t) =>
      other is DangerColor ? DangerColor(Color.lerp(color, other.color, t)!) : this;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(
        brightness: Brightness.light,
        background: const Color(0xFFF3F8F7),
        surface: const Color(0xFFFFFFFF),
        border: const Color(0xFFD5E4E2),
        text: const Color(0xFF10201F),
        textSecondary: const Color(0xFF5B7370),
        accent: const Color(0xFF0F766E),
        onAccent: Colors.white,
        danger: const Color(0xFFB3261E),
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        background: const Color(0xFF0D1514),
        surface: const Color(0xFF142120),
        border: const Color(0xFF233634),
        text: const Color(0xFFE4EFED),
        textSecondary: const Color(0xFF8FA8A5),
        accent: const Color(0xFF2DD4BF),
        onAccent: const Color(0xFF062B27),
        danger: const Color(0xFFF2766B),
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color border,
    required Color text,
    required Color textSecondary,
    required Color accent,
    required Color onAccent,
    required Color danger,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: accent,
      onPrimary: onAccent,
      secondary: accent,
      onSecondary: onAccent,
      // Red is used only for delete and error messages.
      error: danger,
      onError: brightness == Brightness.light ? Colors.white : const Color(0xFF2B0A07),
      surface: surface,
      onSurface: text,
      outline: border,
      onSurfaceVariant: textSecondary,
    );

    OutlineInputBorder outline(Color c, [double w = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: c, width: w),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      extensions: [DangerColor(danger)],
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: text,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: text,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: border),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? onAccent : textSecondary,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? accent : border,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? accent : textSecondary,
        ),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: onAccent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: background,
        labelStyle: TextStyle(color: textSecondary),
        errorStyle: TextStyle(color: danger),
        border: outline(border),
        enabledBorder: outline(border),
        focusedBorder: outline(accent, 1.5),
        errorBorder: outline(danger),
        focusedErrorBorder: outline(danger, 1.5),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: onAccent,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: accent),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: border),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: text,
        contentTextStyle: TextStyle(color: background),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
