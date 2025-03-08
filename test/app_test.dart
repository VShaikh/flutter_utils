import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_info_plus/src/device_info_plus_linux.dart';
import 'package:device_info_plus_platform_interface/device_info_plus_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('registered instance', () async{
    DeviceInfoPlusLinuxPlugin.registerWith();
    expect(DeviceInfoPlatform.instance, isA<DeviceInfoPlusLinuxPlugin>());
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var info = await  deviceInfo.deviceInfo;
    print(info.data);

    var linfo = await  deviceInfo.linuxInfo;
    print(linfo);
  });
}
