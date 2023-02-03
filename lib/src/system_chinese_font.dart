import 'dart:ui';

import 'package:flutter/material.dart';

/// TODO vivo, oppo
/// TODO web

class SystemChineseFont {
  /// Chinese font family fallback, for iOS & macOS
  static const List<String> appleFontFamily = [
    // '.SF UI Text',
    '.AppleSystemUIFont',
    'PingFang SC',
  ];

  /// Chinese font family fallback, for xiaomi phone & redmi phone
  static const List<String> xiaomiFontFamily = [
    'miui',
    'mipro',
  ];

  /// Chinese font family fallback, for windows
  static const List<String> windowsFontFamily = [
    'Microsoft YaHei',
  ];

  /// Chinese font family fallback, for most smartphone brands
  static const List<String> fontFamilyFallback = [
    ...appleFontFamily,
    ...xiaomiFontFamily,
    ...windowsFontFamily,
  ];

  /// Text style with updated fontFamilyFallback & fontVariations
  static TextStyle get textStyle {
    return const TextStyle().useSystemChineseFont();
  }
}

extension UseSystemChineseFont on TextStyle {
  /// Add fontFamilyFallback & fontVariation to original font style
  TextStyle useSystemChineseFont() {
    return copyWith(
      fontFamilyFallback: [
        ...?fontFamilyFallback,
        ...SystemChineseFont.fontFamilyFallback,
      ],
      fontVariations: [
        ...?fontVariations,
        if (fontWeight != null)
          FontVariation('wght', (fontWeight!.index + 1) * 100),
      ],
    );
  }
}
