import 'package:flutter/services.dart';

enum _FontSource { asset }

class DynamicFont {
  final String fontFamily;
  final String uri;
  final _FontSource _source;

  DynamicFont.asset({required this.fontFamily, required String path})
      : _source = _FontSource.asset,
        uri = path;

  Future<void> load() {
    switch (_source) {
      case _FontSource.asset:
        final loader = FontLoader(fontFamily);
        final fontData = rootBundle.load(uri);
        loader.addFont(fontData);
        return loader.load();
    }
  }
}
