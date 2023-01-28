library chinese_font_library;

import 'package:flutter/material.dart';

class DefaultChineseFont {
  static const List<String> fontFamilyFallback = [
    ...appleFontFamily,
    ...xiaomiFontFamily,
  ];

  static const List<String> appleFontFamily = [
    // '.SF UI Text',
    '.AppleSystemUIFont',
    'PingFang SC',
  ];

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
