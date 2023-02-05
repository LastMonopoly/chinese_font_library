import 'dart:math';

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final customFontFamily = "CustomFont${Random().nextInt(100)}";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              final stopwatch = Stopwatch()..start();
              await DynamicFont.url(
                fontFamily: customFontFamily,
                url:
                    'https://raw.githubusercontent.com/LastMonopoly/chinese_font_library/master/example/assets/SmileySans-Oblique.ttf',
              ).load();
              stopwatch.stop();
              debugPrint(
                  "Font loading uses ${stopwatch.elapsedMilliseconds} ms");
            },
            icon: const Icon(Icons.download),
          ),
        ),
        body: Center(child: FontWeightDemo(fontFamily: customFontFamily)),
      ),
    );
  }
}

class FontWeightDemo extends StatelessWidget {
  final String? fontFamily;
  const FontWeightDemo({super.key, required this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      children: FontWeight.values
          .map(
            (weight) => FittedBox(
              child: Text(
                '你好世界 hello world',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: weight,
                ).useSystemChineseFont(),
              ),
            ),
          )
          .toList(),
    );
  }
}
