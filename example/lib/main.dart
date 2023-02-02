import 'package:example/font_loader_demo.dart';
import 'package:flutter/material.dart';

import 'font_weight_demo.dart';
import 'text_theme_demo.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool useDefaultChineseFont = true;
  int currentPageIndex = 0;

  Widget get content {
    switch (currentPageIndex) {
      case 0:
        return FontWeightDemo(useDefaultChineseFont: useDefaultChineseFont);
      case 1:
        return TextThemeDemo(useDefaultChineseFont: useDefaultChineseFont);
      default:
        return const FontLoaderDemo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        appBarTheme: const AppBarTheme(centerTitle: false),
      ),
      home: Scaffold(
        appBar: currentPageIndex < 2
            ? AppBar(
                title: const Text('Chinese Font Library Demo'),
                actions: [
                  Switch(
                      value: useDefaultChineseFont,
                      onChanged: (value) {
                        setState(() {
                          useDefaultChineseFont = value;
                        });
                      })
                ],
              )
            : null,
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.text_fields),
              label: 'Font weight',
            ),
            NavigationDestination(
              icon: Icon(Icons.palette_outlined),
              selectedIcon: Icon(Icons.palette),
              label: 'Text theme',
            ),
            NavigationDestination(
              icon: Icon(Icons.translate),
              label: 'Font loader',
            ),
          ],
        ),
        body: content,
      ),
    );
  }
}
