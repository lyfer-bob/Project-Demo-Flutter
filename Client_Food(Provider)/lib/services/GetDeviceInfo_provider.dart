import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDeviceInfoProvider extends ChangeNotifier {
  GetDeviceInfoProvider();

  GetDeviceInfoProvider.init() {
    getDeviceInfo();
  }

  getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    var preferences = await SharedPreferences.getInstance();

    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;

        preferences.setString('platform', 'android');
        preferences.setString('deviceName', build.model);
        preferences.setString('deviceVersion', build.version.toString());
        preferences.setString('deviceId', build.androidId);
        print('DATA an :: ${build.androidId}');

      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;

        preferences.setString('platform', 'ios');
        preferences.setString('deviceName', data.name);
        preferences.setString('deviceVersion', data.systemVersion.toString());
        preferences.setString('deviceId', data.identifierForVendor);
        print('DATAAAAA :: ${data.identifierForVendor}');
      }

      notifyListeners();
    } catch (e) {
      print('ErrorFromGetDeviceId:: $e');
    }
  }
}
