import 'dart:math' hide log;

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:developer';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final customFontFamily = "CustomFont${Random().nextInt(1000)}";
    _logDeviceInfo();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', ''),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
        Locale('en', ''),
      ],
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

Future<void> _logDeviceInfo() async {
  final plugin = DeviceInfoPlugin();

  if (kIsWeb) {
    final info = await plugin.webBrowserInfo;
    log('Web info: $info');
    return;
  }

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      final info = await plugin.androidInfo;
      log('Android info: $info');
      return;
    case TargetPlatform.iOS:
      final info = await plugin.iosInfo;
      log('iOS info: $info');
      return;
    case TargetPlatform.macOS:
      final info = await plugin.macOsInfo;
      log('macOS info: $info');
      return;
    case TargetPlatform.windows:
      final info = await plugin.windowsInfo;
      log('Windows info: $info');
      return;
    case TargetPlatform.linux:
      final info = await plugin.linuxInfo;
      log('Linux info: $info');
      return;
    case TargetPlatform.fuchsia:
      log('Fuchsia info: not supported');
      return;
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
