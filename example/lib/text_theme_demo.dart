import 'package:flutter/material.dart';

class TextThemeDemo extends StatelessWidget {
  const TextThemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: _buildThemedText(context));
  }

  List<Widget> _buildThemedText(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textList = <Widget>[];

    final styles = <TextStyle?>[
      textTheme.displayLarge,
      textTheme.displayMedium,
      textTheme.displaySmall,
      textTheme.headlineLarge,
      textTheme.headlineMedium,
      textTheme.headlineSmall,
      textTheme.titleLarge,
      textTheme.titleMedium,
      textTheme.titleSmall,
      textTheme.bodyLarge,
      textTheme.bodyMedium,
      textTheme.bodySmall,
      textTheme.labelLarge,
      textTheme.labelMedium,
      textTheme.labelSmall,
    ];
    for (var style in styles) {
      textList.add(Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          '给心灵放个假',
          style: style?.copyWith(fontWeight: FontWeight.w200),
        ),
      ));
    }
    return textList;
  }
}
