import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool useCustomFont = false;

  @override
  Widget build(BuildContext context) {
    const customFontFamily = "CustomFontFromWeb";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              DynamicFont.url(
                fontFamily: customFontFamily,
                url:
                    'https://raw.githubusercontent.com/LastMonopoly/chinese_font_library/master/example/assets/SmileySans-Oblique.ttf',
              ).load().then((success) {
                if (success) {
                  setState(() {
                    useCustomFont = true;
                  });
                }
              });
            },
            icon: const Icon(Icons.download),
          ),
        ),
        body: Center(
          child: FontWeightDemo(
            fontFamily: useCustomFont ? customFontFamily : null,
          ),
        ),
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
