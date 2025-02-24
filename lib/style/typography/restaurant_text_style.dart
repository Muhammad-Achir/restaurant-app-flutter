import 'package:flutter/material.dart';

class RestaurantTextStyle {
  static const TextStyle _displayStyle = TextStyle(
    fontFamily: 'ADLaM Display',
  );
  static const TextStyle _commonStyle = TextStyle(
    fontFamily: 'OpenSans',
  );

  /// displayLarge Text Style
  static TextStyle displayLarge = _displayStyle.copyWith(
    fontSize: 57,
    height: 1.11,
    letterSpacing: -2,
  );

  /// displayMedium Text Style
  static TextStyle displayMedium = _displayStyle.copyWith(
    fontSize: 45,
    height: 1.17,
    letterSpacing: -1,
  );

  /// displaySmall Text Style
  static TextStyle displaySmall = _displayStyle.copyWith(
    fontSize: 24,
    height: 1.25,
    letterSpacing: -1,
  );

  /// headlineLarge Text Style
  static TextStyle headlineLarge = _commonStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    height: 1.5,
    letterSpacing: -1,
  );

  /// headlineMedium Text Style
  static TextStyle headlineMedium = _commonStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 1.2,
  );

  /// headlineMedium Text Style
  static TextStyle headlineSmall = _commonStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: -1,
  );

  /// titleLarge Text Style
  static TextStyle titleLarge = _commonStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 1.2,
  );

  /// titleMedium Text Style
  static TextStyle titleMedium = _commonStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 1.2,
  );

  /// titleSmall Text Style
  static TextStyle titleSmall = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    height: 1.2,
    letterSpacing: 1.2,
  );

  /// bodyLarge Text Style
  static TextStyle bodyLarge = _commonStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    height: 1.56,
  );

  /// bodyMedium Text Style
  static TextStyle bodyMedium = _commonStyle.copyWith(
    fontSize: 16,
    // fontWeight: FontWeight.w300,
    height: 1.56,
    letterSpacing: 1.4,
  );

  /// bodySmall Text Style
  static TextStyle bodySmall = _commonStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.56,
  );

  /// labelLarge Text Style
  static TextStyle labelLarge = _commonStyle.copyWith(
    fontSize: 14,
    height: 1.7,
    letterSpacing: 1.4,
  );

  /// labelMedium Text Style
  static TextStyle labelMedium = _commonStyle.copyWith(
    fontSize: 12,
    height: 1.4,
    letterSpacing: 1.3,
  );

  /// labelSmall Text Style
  static TextStyle labelSmall = _commonStyle.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w300,
    height: 1.2,
    letterSpacing: 1.3,
  );
}
