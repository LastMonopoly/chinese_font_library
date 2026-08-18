## 1.3.0

* Migrate to Flutter 3.47.0
* **Breaking**: require Flutter `>=3.41.0` & Dart `>=3.11.0`
* Replace the deprecated `FontWeight.index` with `FontWeight.value`, so
  `useSystemChineseFont()` now keeps arbitrary weights such as `FontWeight(550)`
  exact instead of rounding them down to the nearest 100
* Use `FontVariation.weight` instead of the raw `wght` axis name
* Await the font file write in `downloadFont`, so the cached file is complete
  before the bytes are returned
* Add `repository`, `issue_tracker` & `topics` to `pubspec.yaml`
* Add a sponsor section to the README

## 1.2.0

* Migrate to Flutter 3.22.0

## 1.1.0

* Add Brightness to `useSystemChineseFont` to fix [#4](https://github.com/LastMonopoly/chinese_font_library/issues/4)

## 1.0.2

* Update dependencies

## 1.0.1

* Using Asynchronous IO Methods

## 1.0.0

* Fix the font loading logic for Vivo
* Should work on most platforms

## 0.6.1

* Update screenshots

## 0.6.0

* Add support for Oppo, Vivo, and Honor

## 0.5.0

* Support web build when  `web-renderer` is `html` (instead of `canvaskit`)

## 0.4.0

* Add `.useSystemChineseFont()` to `TextTheme`
* Add `.useSystemChineseFont()` to `ThemeData`
  
## 0.3.4

* Use `sans-serif` as the first `fontFamilyFallback`

## 0.3.3

* Improve example code
* Improve documentation

## 0.3.1

* Improve documentation
  
## 0.3.0

* Add `SystemChineseFont.textTheme` for `ThemeData`
  
## 0.2.0

* Support for system Chinese font on Apple, Xiaomi, and Windows
* Support for dynamically load fonts from url, file, and asset
