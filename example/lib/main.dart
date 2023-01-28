import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool useDefaultChineseFont = true;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        textTheme: useDefaultChineseFont ? DefaultChineseFont.textTheme : null,
      ),
      home: Scaffold(
        appBar: AppBar(
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
          centerTitle: false,
        ),
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
          ],
        ),
        body: currentPageIndex == 0
            ? const FontWeightDemo()
            : const TextThemeDemo(),
      ),
    );
  }
}

class FontWeightDemo extends StatelessWidget {
  const FontWeightDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildFittedText(FontWeight.w100),
        _buildFittedText(FontWeight.w200),
        _buildFittedText(FontWeight.w300),
        _buildFittedText(FontWeight.w400),
        _buildFittedText(FontWeight.w500),
        _buildFittedText(FontWeight.w600),
        _buildFittedText(FontWeight.w700),
        _buildFittedText(FontWeight.w800),
        _buildFittedText(FontWeight.w900),
      ],
    );
  }

  _buildFittedText(FontWeight weight) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        child: Text(
          '焦虑时代 一方净土 Hello world',
          style: TextStyle(fontWeight: weight),
        ),
      ),
    );
  }
}

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
