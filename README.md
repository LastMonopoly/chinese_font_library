<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

chinese_font_library 意在优化中文字体的跨平台渲染，目前支持：
- 多字重的渲染
- 动态加载字体

## Features

**多字重的渲染**

Flutter使用的系统默认字体多为西文字体，因此不同平台下的中文字体通常渲染为normal字重或bold字重，且bold字重为计算后得到的字重，并非原生bold字重，严重影响观感。

解决方案为使用`.useSystemChineseFont()`修改已有的`textStyle`:

```dart
Text(
    '你好世界 hello world',
    style: TextStyle(fontWeight: FontWeight.w100).useSystemChineseFont(),
)
```

或者, `SystemChineseFont.textTheme.merge`已有的`textTheme`:

```dart
return MaterialApp(
    ...
    theme: Theme(
        data: ThemeData(
          textTheme: SystemChineseFont.textTheme.merge(yourCustomTextTheme),
        ),
    ),
    ...
)
```

**动态加载字体**

如果您不满足于系统内置的中文字体，想使用自己精选的中文字体，而中文字体通常体积较大，放在安装包中并非最佳选择。

解决方案为通过网络动态加载字体，仅需下载一次：

```dart
DynamicFont.url(
    fontFamily: 'CustomFontFromWeb',
    url: 'https://raw.githubusercontent.com/LastMonopoly/chinese_font_library/master/example/assets/SmileySans-Oblique.ttf',
).load()
```

## Results

![Font weights demo from multiple devices](https://raw.githubusercontent.com/LastMonopoly/chinese_font_library/master/screenshots/combined.png)

## Getting started

Inside `pubspec.yaml` file, add the following dependency:

```yaml
dependencies:
  ...
  chinese_font_library: ^0.3.3
```

Then, use `SystemChineseFont.textTheme` for your `ThemeData`

```dart
return MaterialApp(
    ...
    theme: Theme(
        data: ThemeData(textTheme: SystemChineseFont.textTheme),        
    ),
    ...
)
```

## Roadmap

如有任何意见或建议，请在Github上联系我。

|  iOS  | 华为鸿蒙 | 小米 miui | macOS | Windows | Vivo  | Oppo  | Linux |  Web  |
| :---: | :------: | :-------: | :---: | :-----: | :---: | :---: | :---: | :---: |
|   ✔️   |    ✔️     |     ✔️     |   ✔️   |    ✔️    |
