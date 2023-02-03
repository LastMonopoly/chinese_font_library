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

Flutter使用的系统默认字体多为西文字体，因此不同平台下的中文字体通常渲染为regular字重或bold字重，且bold字重为通过计算得到的字重，并非原生bold字重，严重影响观感。

解决方案为使用`.useSystemChineseFont()`修改已有的`textStyle`

```dart
Text(
    '你好世界 hello world',
    style: TextStyle(fontWeight: FontWeight.w100).useSystemChineseFont(),
)
```

**动态加载字体**

如果您不满足于系统内置的中文字体，想使用自己精选的中文字体，而中文字体通常体积较大，放在安装包中并非最佳选择，可以通过网络动态加载

```dart
DynamicFont.url(
    fontFamily: 'CustomFontFromWeb',
    url: 'https://raw.githubusercontent.com/LastMonopoly/chinese_font_library/master/example/assets/SmileySans-Oblique.ttf',
).load()
```

## Results

## Roadmap

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```