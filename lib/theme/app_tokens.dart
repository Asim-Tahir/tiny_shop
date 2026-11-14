import 'package:flutter/material.dart';

abstract final class AppColors {
  static const background = Color(0xFFFFFFFF);
  static const surfaceMuted = Color(0xFFF5F5F7);
  static const primary = Color(0xFF1976D2);
  static const textPrimary = Color(0xFF000000);
  static const textInverse = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF757575);
  static const textMuted = Color(0xFF9E9E9E);
  static const textSubtle = Color(0xFF616161);
  static const danger = Color(0xFFF44336);
  static const success = Color(0xFF4CAF50);
  static const shadow = Color(0x42000000);
}

abstract final class AppSpacing {
  static const xxs = 2.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const compact = 10.0;
  static const md = 12.0;
  static const relaxed = 14.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const xxl = 24.0;
  static const xxxl = 32.0;
}

abstract final class AppRadii {
  static const sm = 8.0;
  static const md = 12.0;
}

abstract final class AppSizes {
  static const cartThumbnail = 70.0;
  static const quantityField = 48.0;
  static const emptyStateIcon = 64.0;
  static const buttonHeight = 55.0;
  static const bannerHeight = 80.0;
  static const productImageHeight = 350.0;
}

abstract final class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary)
        .copyWith(error: AppColors.danger),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      displaySmall: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 22),
      headlineSmall: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      bodySmall: TextStyle(fontSize: 12),
      labelSmall: TextStyle(fontSize: 13),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      isDense: true,
    ),
  );
}
