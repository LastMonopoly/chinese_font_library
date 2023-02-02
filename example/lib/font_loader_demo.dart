import 'dart:async';

import 'dart:io';
import 'dart:math';

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

enum FontSource { system, asset, file, url }

class FontLoaderDemo extends StatefulWidget {
  const FontLoaderDemo({super.key});

  @override
  State<FontLoaderDemo> createState() => _FontLoaderDemoState();
}

class _FontLoaderDemoState extends State<FontLoaderDemo> {
  late final String fontFamily;

  TextStyle defaultTextStyle = const TextStyle(fontSize: 15);

  late FontSource _selectedFontSource;

  FontSource get selectedFontSource => _selectedFontSource;

  set selectedFontSource(FontSource s) {
    setState(() {
      _selectedFontSource = s;
      switch (s) {
        case FontSource.system:
          defaultTextStyle = DefaultChineseFont.textStyle;
          break;
        case FontSource.asset:
        case FontSource.file:
        case FontSource.url:
          defaultTextStyle = DefaultChineseFont.textStyle.copyWith(
            fontFamily: fontFamily,
            fontSize: 15,
          );
          break;
      }
    });
    loadFont();
  }

  @override
  void initState() {
    super.initState();
    fontFamily = Random().nextInt(100000).toString();
    selectedFontSource = FontSource.asset;
  }

  loadFont() async {
    DynamicFont? font;
    switch (selectedFontSource) {
      case FontSource.system:
        break;
      case FontSource.asset:
        font = DynamicFont.asset(
          fontFamily: fontFamily,
          key: 'assets/Lato-Regular.ttf',
        );
        break;
      case FontSource.file:
        const url =
            'https://raw.githubusercontent.com/LastMonopoly/chinese_font_library/master/example/assets/Lato-Italic.ttf';
        final uri = Uri.parse(url);
        final filename = uri.pathSegments.last;
        final dir = (await getApplicationSupportDirectory()).path;
        final filepath = '$dir/$filename';
        await downloadFontTo(url, filepath: filepath, overwrite: true);

        font = DynamicFont.file(fontFamily: fontFamily, filepath: filepath);
        break;
      case FontSource.url:
        font = DynamicFont.url(
          fontFamily: fontFamily,
          url:
              'https://raw.githubusercontent.com/LastMonopoly/chinese_font_library/master/example/assets/Lato-Light.ttf',
        );
        break;
    }
    font?.load().then((success) {
      if (success && mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Load font from ${selectedFontSource.name}'),
        actions: [
          PopupMenuButton<FontSource>(
            initialValue: selectedFontSource,
            onSelected: (FontSource item) {
              selectedFontSource = item;
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FontSource>>[
              PopupMenuItem<FontSource>(
                value: FontSource.system,
                child: Text('From ${FontSource.system.name}'),
              ),
              PopupMenuItem<FontSource>(
                value: FontSource.asset,
                child: Text('From ${FontSource.asset.name}'),
              ),
              PopupMenuItem<FontSource>(
                value: FontSource.file,
                child: Text('From ${FontSource.file.name}'),
              ),
              PopupMenuItem<FontSource>(
                value: FontSource.url,
                child: Text('From ${FontSource.url.name}'),
              ),
            ],
          )
        ],
      ),
      body: DefaultTextStyle(
        style: defaultTextStyle,
        child: const DeviceInfo(),
      ),
    );
  }
}

class DeviceInfo extends StatefulWidget {
  const DeviceInfo({Key? key}) : super(key: key);

  @override
  State<DeviceInfo> createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initDeviceData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: deviceData.keys.map(
        (String property) {
          return Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(15),
                child: Text(
                  property,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    '${deviceData[property]}',
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ],
          );
        },
      ).toList(),
    );
  }

  Future<void> initDeviceData() async {
    var data = <String, dynamic>{};

    try {
      if (kIsWeb) {
        data = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          data = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          data = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          data = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          data = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          data = _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      data = <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }

    if (!mounted) return;

    setState(() {
      deviceData = data;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
          ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'version': data.version,
      'id': data.id,
      'idLike': data.idLike,
      'versionCodename': data.versionCodename,
      'versionId': data.versionId,
      'prettyName': data.prettyName,
      'buildId': data.buildId,
      'variant': data.variant,
      'variantId': data.variantId,
      'machineId': data.machineId,
    };
  }

  Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    return <String, dynamic>{
      'browserName': describeEnum(data.browserName),
      'appCodeName': data.appCodeName,
      'appName': data.appName,
      'appVersion': data.appVersion,
      'deviceMemory': data.deviceMemory,
      'language': data.language,
      'languages': data.languages,
      'platform': data.platform,
      'product': data.product,
      'productSub': data.productSub,
      'userAgent': data.userAgent,
      'vendor': data.vendor,
      'vendorSub': data.vendorSub,
      'hardwareConcurrency': data.hardwareConcurrency,
      'maxTouchPoints': data.maxTouchPoints,
    };
  }

  Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      'computerName': data.computerName,
      'hostName': data.hostName,
      'arch': data.arch,
      'model': data.model,
      'kernelVersion': data.kernelVersion,
      'osRelease': data.osRelease,
      'activeCPUs': data.activeCPUs,
      'memorySize': data.memorySize,
      'cpuFrequency': data.cpuFrequency,
      'systemGUID': data.systemGUID,
    };
  }

  Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return <String, dynamic>{
      'numberOfCores': data.numberOfCores,
      'computerName': data.computerName,
      'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
      'userName': data.userName,
      'majorVersion': data.majorVersion,
      'minorVersion': data.minorVersion,
      'buildNumber': data.buildNumber,
      'platformId': data.platformId,
      'csdVersion': data.csdVersion,
      'servicePackMajor': data.servicePackMajor,
      'servicePackMinor': data.servicePackMinor,
      'suitMask': data.suitMask,
      'productType': data.productType,
      'reserved': data.reserved,
      'buildLab': data.buildLab,
      'buildLabEx': data.buildLabEx,
      'digitalProductId': data.digitalProductId,
      'displayVersion': data.displayVersion,
      'editionId': data.editionId,
      'installDate': data.installDate,
      'productId': data.productId,
      'productName': data.productName,
      'registeredOwner': data.registeredOwner,
      'releaseId': data.releaseId,
      'deviceId': data.deviceId,
    };
  }
}
