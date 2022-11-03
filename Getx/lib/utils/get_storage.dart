import 'dart:async' show Future;
import 'package:get_storage/get_storage.dart';

class DataStorage {
  static final box = GetStorage('SdbStorage');

  static const _keyPlatform = 'platform'; // ios and andriod
  static const _keyDeviceName = 'deviceName'; // M2007J3SY

  static Future<void> setPlatform(String value) =>
      box.write(_keyPlatform, value);

  static Future<void> setDeviceName(String value) =>
      box.write(_keyDeviceName, value);

  static String? getPlatform() => box.read(_keyPlatform);
  static String? getDeviceName() => box.read(_keyDeviceName);
}
