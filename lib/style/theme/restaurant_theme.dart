import 'package:flutter/material.dart';
import 'package:restaurant_app/style/color/restaurant_color_scheme.dart';
import 'package:restaurant_app/style/typography/restaurant_text_style.dart';

class RestaurantTheme {
  static ThemeData get lightTheme {
    final colorScheme = RestaurantColorScheme.lightColorScheme;

    return ThemeData(
      colorScheme: colorScheme,
      brightness: Brightness.light,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme(colorScheme),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = RestaurantColorScheme.darkColorScheme;

    return ThemeData(
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme(colorScheme),
    );
  }

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: colorScheme.onPrimary,
      foregroundColor: colorScheme.primary,
      elevation: 4,
      toolbarTextStyle: _textTheme.displaySmall?.copyWith(
        color: colorScheme.primary,
      ),
      titleTextStyle: _textTheme.displaySmall?.copyWith(
        color: colorScheme.primary,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: RestaurantTextStyle.displayLarge,
      displayMedium: RestaurantTextStyle.displayMedium,
      displaySmall: RestaurantTextStyle.displaySmall,
      headlineLarge: RestaurantTextStyle.headlineLarge,
      headlineMedium: RestaurantTextStyle.headlineMedium,
      headlineSmall: RestaurantTextStyle.headlineSmall,
      titleLarge: RestaurantTextStyle.titleLarge,
      titleMedium: RestaurantTextStyle.titleMedium,
      titleSmall: RestaurantTextStyle.titleSmall,
      bodyLarge: RestaurantTextStyle.bodyLarge,
      bodyMedium: RestaurantTextStyle.bodyMedium,
      bodySmall: RestaurantTextStyle.bodySmall,
      labelLarge: RestaurantTextStyle.labelLarge,
      labelMedium: RestaurantTextStyle.labelMedium,
      labelSmall: RestaurantTextStyle.labelSmall,
    );
  }
}
