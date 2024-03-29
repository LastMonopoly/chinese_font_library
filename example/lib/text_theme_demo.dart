import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

class TextThemeDemo extends StatelessWidget {
  final bool useSystemChineseFont;

  const TextThemeDemo({super.key, required this.useSystemChineseFont});

  @override
  Widget build(BuildContext context) {
    if (useSystemChineseFont) {
      final brightness = Theme.of(context).brightness;
      return Theme(
        data: ThemeData(
          textTheme: const TextTheme(
            headlineLarge: TextStyle(),
            displaySmall: TextStyle(),
            displayMedium: TextStyle(),
            displayLarge: TextStyle(),
          ).apply(fontFamily: 'LatoLato').useSystemChineseFont(brightness),
        ),
        child: const ThemedTextList(),
      );
    } else {
      return const ThemedTextList();
    }
  }
}

class ThemedTextList extends StatelessWidget {
  const ThemedTextList({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final styles = <TextStyle?>[
      textTheme.labelSmall,
      textTheme.labelMedium,
      textTheme.labelLarge,
      textTheme.bodySmall,
      textTheme.bodyMedium,
      textTheme.bodyLarge,
      textTheme.titleSmall,
      textTheme.titleMedium,
      textTheme.titleLarge,
      textTheme.headlineSmall,
      textTheme.headlineMedium,
      textTheme.headlineLarge,
      textTheme.displaySmall,
      textTheme.displayMedium,
      textTheme.displayLarge,
    ];

    return ListView(
      children: styles
          .map((style) => Padding(
                padding: const EdgeInsets.all(10),
                child: Text('给心灵放个假 159', style: style),
              ))
          .toList(),
    );
  }
}
