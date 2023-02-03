import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download),
          ),
        ),
        body: const Center(child: FontWeightDemo()),
      ),
    );
  }
}

class FontWeightDemo extends StatefulWidget {
  const FontWeightDemo({super.key});

  @override
  State<FontWeightDemo> createState() => _FontWeightDemoState();
}

class _FontWeightDemoState extends State<FontWeightDemo> {
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
                style: TextStyle(fontWeight: weight).useSystemChineseFont(),
              ),
            ),
          )
          .toList(),
    );
  }
}
