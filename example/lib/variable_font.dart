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
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: const FittedBox(child: VariableFontDemo()),
          ),
        ),
      ),
    );
  }
}

class VariableFontDemo extends StatefulWidget {
  const VariableFontDemo({super.key});

  @override
  State<VariableFontDemo> createState() => _VariableFontDemoState();
}

class _VariableFontDemoState extends State<VariableFontDemo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: FontWeight.values
          .map(
            (weight) => Text(
              '你好世界 hello world',
              style: TextStyle(fontWeight: weight).useSystemChineseFont(),
            ),
          )
          .toList(),
    );
  }
}
