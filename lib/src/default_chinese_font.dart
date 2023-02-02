import 'package:flutter/material.dart';

/// TODO xiaomi
/// TODO web

class DefaultChineseFont {
  /// Chinese font family fallback, for iOS & macOS
  static const List<String> appleFontFamily = [
    // '.SF UI Text',
    '.AppleSystemUIFont',
    'PingFang SC',
  ];

  /// Chinese font family fallback, for xiaomi phone & redmi phone
  static const List<String> xiaomiFontFamily = [
    'mipro',
    'mipro-thin',
    'mipro-extralight',
    'mipro-light',
    'mipro-normal',
    'mipro-regular',
    'mipro-medium',
    'mipro-demibold',
    'mipro-semibold',
    'mipro-bold',
    'mipro-heavy',
  ];

  /// Chinese font family fallback, for most smartphone brands
  static const List<String> fontFamilyFallback = [
    ...appleFontFamily,
    ...xiaomiFontFamily,
  ];

  /// Text style with updated fontFamilyFallback
  static TextStyle get textStyle {
    return const TextStyle(fontFamilyFallback: fontFamilyFallback);
  }

  /// Text theme with updated fontFamilyFallback
  static TextTheme get textTheme {
    TextStyle style = const TextStyle(fontFamilyFallback: fontFamilyFallback);

    return TextTheme(
      displayLarge: style,
      displayMedium: style,
      displaySmall: style,
      headlineLarge: style,
      headlineMedium: style,
      headlineSmall: style,
      titleLarge: style,
      titleMedium: style,
      titleSmall: style,
      bodyLarge: style,
      bodyMedium: style,
      bodySmall: style,
      labelLarge: style,
      labelMedium: style,
      labelSmall: style,
    );
  }
}
