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

  Future<bool> load() async {
    switch (_source) {
      case _FontSource.asset:
        try {
          final loader = FontLoader(fontFamily);
          final fontData = rootBundle.load(uri);
          loader.addFont(fontData);
          await loader.load();
          return true;
        } catch (e) {
          debugPrint("Font asset error!!!");
          debugPrint(e.toString());
          return false;
        }
      case _FontSource.url:
        try {
          await loadFontFromList(
            await downloadFont(uri),
            fontFamily: fontFamily,
          );
          return true;
        } catch (e) {
          debugPrint("Font download failed!!!");
          debugPrint(e.toString());
          return false;
        }
    }
  }
}

FutureOr<Uint8List> downloadFont(String url) async {
  final uri = Uri.parse(url);
  final filename = uri.pathSegments.last;
  final dir = (await getApplicationSupportDirectory()).path;
  final file = File('$dir/$filename');

  if (file.existsSync()) {
    return file.readAsBytesSync();
  }

  final client = http.Client();
  final request = http.Request('GET', uri);
  final response =
      await client.send(request).timeout(const Duration(seconds: 5));

  if (response.statusCode != 200) {
    throw HttpException("status code ${response.statusCode}");
  }

  List<int> rawData = [];
  await response.stream.listen((List<int> chunk) {
    rawData.addAll(chunk);
    debugPrint('download font: ${rawData.length}');
  }).asFuture();

  final Uint8List bytes = Uint8List.fromList(rawData);
  file.writeAsBytes(bytes);
  return bytes;
}
