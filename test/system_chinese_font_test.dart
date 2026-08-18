import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextStyle.useSystemChineseFont', () {
    test('appends the Chinese font family fallback', () {
      final style = const TextStyle().useSystemChineseFont();

      expect(
        style.fontFamilyFallback,
        containsAllInOrder(<String>[
          SystemChineseFont.systemFont,
          'sans-serif',
          ...SystemChineseFont.appleFontFamily,
          ...SystemChineseFont.xiaomiFontFamily,
          ...SystemChineseFont.windowsFontFamily,
        ]),
      );
    });

    test('keeps a font family fallback that is already set', () {
      final style = const TextStyle(
        fontFamilyFallback: <String>['MyFont'],
      ).useSystemChineseFont();

      expect(style.fontFamilyFallback!.first, 'MyFont');
    });

    test('adds no weight variation when fontWeight is null', () {
      final style = const TextStyle().useSystemChineseFont();

      expect(style.fontVariations, isEmpty);
    });

    test('maps a predefined fontWeight to the wght axis', () {
      final style = const TextStyle(
        fontWeight: FontWeight.w100,
      ).useSystemChineseFont();

      expect(style.fontVariations, const [FontVariation('wght', 100)]);
    });

    test('keeps an arbitrary fontWeight exact', () {
      final style = const TextStyle(
        fontWeight: FontWeight(550),
      ).useSystemChineseFont();

      expect(style.fontVariations, const [FontVariation('wght', 550)]);
    });

    test('keeps font variations that are already set', () {
      final style = const TextStyle(
        fontWeight: FontWeight.w700,
        fontVariations: <FontVariation>[FontVariation('slnt', -5)],
      ).useSystemChineseFont();

      expect(style.fontVariations, const [
        FontVariation('slnt', -5),
        FontVariation('wght', 700),
      ]);
    });
  });

  group('TextTheme.useSystemChineseFont', () {
    test('applies the fallback to every text style', () {
      final theme = Typography.material2021().black.useSystemChineseFont(
        Brightness.light,
      );

      for (final style in <TextStyle?>[
        theme.displayLarge,
        theme.bodyMedium,
        theme.labelSmall,
      ]) {
        expect(
          style!.fontFamilyFallback,
          contains(SystemChineseFont.systemFont),
        );
      }
    });

    test('keeps the original color for a dark text theme', () {
      final theme = Typography.material2021().white.useSystemChineseFont(
        Brightness.dark,
      );

      expect(
        theme.bodyMedium!.color,
        Typography.material2021().white.bodyMedium!.color,
      );
    });
  });

  group('ThemeData.useSystemChineseFont', () {
    test('replaces the text theme with a fallback aware one', () {
      final themeData = ThemeData.light().useSystemChineseFont(
        Brightness.light,
      );

      expect(
        themeData.textTheme.bodyMedium!.fontFamilyFallback,
        contains(SystemChineseFont.systemFont),
      );
    });
  });
}
