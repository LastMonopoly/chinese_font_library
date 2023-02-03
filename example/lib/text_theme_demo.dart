import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

class TextThemeDemo extends StatelessWidget {
  final bool useDefaultChineseFont;

  const TextThemeDemo({super.key, required this.useDefaultChineseFont});

  @override
  Widget build(BuildContext context) {
    return ListView(children: _buildThemedText(context));
  }

  List<Widget> _buildThemedText(BuildContext context) {
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

    return styles
        .map((style) => Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                '给心灵放个假',
                style: useDefaultChineseFont
                    ? style?.useSystemChineseFont()
                    : style,
              ),
            ))
        .toList();
  }
}
