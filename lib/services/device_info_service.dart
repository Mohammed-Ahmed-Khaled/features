import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> getDeviceInfo() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      return 'Model: ${androidInfo.model}, OS: Android ${androidInfo.version.release}';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return 'Model: ${iosInfo.utsname.machine}, OS: iOS ${iosInfo.systemVersion}';
    }
    return 'Unknown Device';
  }
}
