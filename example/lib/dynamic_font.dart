import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

enum _FontSource { asset, url }

class DynamicFont {
  final String fontFamily;
  final String uri;
  final _FontSource _source;

  DynamicFont.asset({required this.fontFamily, required String path})
      : _source = _FontSource.asset,
        uri = path;

  DynamicFont.url({required this.fontFamily, required String url})
      : _source = _FontSource.url,
        uri = url;

  Future<void> load() async {
    switch (_source) {
      case _FontSource.asset:
        final loader = FontLoader(fontFamily);
        final fontData = rootBundle.load(uri);
        loader.addFont(fontData);
        return loader.load();
      case _FontSource.url:
        loadFontFromList(
          await downloadFont(uri),
          fontFamily: fontFamily,
        );
    }
  }
}

FutureOr<Uint8List> downloadFont(String url) async {
  final uri = Uri.parse(url);
  final filename = uri.pathSegments.last;
  final dirPath = (await getApplicationSupportDirectory()).path;
  final filepath = '$dirPath/$filename';
  final file = File(filepath);

  // if (file.existsSync()) {
  //   return file.readAsBytesSync();
  // }

  debugPrint("Start download...");
  final response = await http.get(uri);
  debugPrint("Done download...");
  file.writeAsBytesSync(response.bodyBytes);
  return response.bodyBytes;
}
