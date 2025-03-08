import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_utils/main.dart';

Future<String> getDeviceName() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (isAndroid()) {
    return (await deviceInfo.androidInfo).model;
  } else if (kIsWeb) {
    return (await deviceInfo.webBrowserInfo).userAgent!;
  } else if (isLinux()) {
    return (await deviceInfo.linuxInfo).prettyName;
  } else {
    return 'Unknown device !!!';
  }
}
