import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

class FontWeightDemo extends StatelessWidget {
  final bool useDefaultChineseFont;
  const FontWeightDemo({super.key, required this.useDefaultChineseFont});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          FontWeight.values.map((weight) => _buildFittedText(weight)).toList(),
    );
  }

  Widget _buildFittedText(FontWeight weight) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        child: Text(
          '焦虑时代 一方净土 Hello world 123',
          style: useDefaultChineseFont
              ? TextStyle(fontWeight: weight).useSystemChineseFont()
              : TextStyle(fontWeight: weight),
        ),
      ),
    );
  }
}
