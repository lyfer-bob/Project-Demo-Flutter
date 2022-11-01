import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDeviceInfoProvider extends ChangeNotifier {
  GetDeviceInfoProvider();

  getDeviceInfo() async {
    print('DeviceInfoPlugin::::::::::::::::::::::::::::::>>>');
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String? deviceId = await PlatformDeviceId.getDeviceId;

    var preferences = await SharedPreferences.getInstance();

    preferences.getBool('stsLogin') ?? preferences.setBool('stsLogin', false);

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo info = await deviceInfo.androidInfo;

        preferences.setString('platform', 'android');
        preferences.setString('deviceName', info.model.toString());
        preferences.setString('deviceVersion', info.version.toString());
        preferences.setString('deviceId', deviceId.toString());

        print(preferences.getString('platform'));
        print(preferences.getString('deviceId'));
      } else if (Platform.isIOS) {
        IosDeviceInfo info = await deviceInfo.iosInfo;

        preferences.setString('platform', 'ios');
        preferences.setString('deviceName', info.name.toString());
        preferences.setString('deviceVersion', info.systemVersion.toString());
        preferences.setString('deviceId', deviceId.toString());

        print('deviceId:::: ${info.identifierForVendor}');
      }

      notifyListeners();
    } catch (e) {
      print('ErrorFromGetDeviceId:: $e');
    }
  }
}
