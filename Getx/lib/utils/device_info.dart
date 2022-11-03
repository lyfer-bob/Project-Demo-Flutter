import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:project/utils/get_storage.dart';

class GetDeviceInfoProvider {
  GetDeviceInfoProvider();
  getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo info = await deviceInfo.androidInfo;
        DataStorage.setPlatform('android');
        DataStorage.setDeviceName(info.model.toString());
      } else if (Platform.isIOS) {
        IosDeviceInfo info = await deviceInfo.iosInfo;
        DataStorage.setPlatform('ios');
        DataStorage.setDeviceName(info.model.toString());
      }
    } catch (e) {
      print('ErrorFromGetDeviceId:: $e');
    }
  }
}
