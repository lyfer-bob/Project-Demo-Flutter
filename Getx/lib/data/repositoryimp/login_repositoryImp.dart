import 'package:flutter/material.dart';
import 'package:project/service/route/route_apipath.dart';
import 'package:project/service/api_provider.dart';
import 'package:project/models/index.dart';
import 'package:project/utils/get_storage.dart';
import '../../utils/dialog_app.dart';
import '../repository/login_repository.dart';

class LoginRepositoryImp implements LoginRepository {
  @override
  Future<dynamic> requestLogin(Login login) async {
    login.deviceId = DataStorage.getDeviceName() ?? '';
    login.deviceName = DataStorage.getPlatform() ?? '';
    login.deviceOS = 'iOS 15.6.1';

    final response =
        await APIProvider.instance.request(ApiPath.login, login.toJson());

    return Loginmodel.fromJson(response);
  }

  bool validateData(String email, String password, BuildContext context) {
    if (email.isEmpty || password.isEmpty) {
      normalDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
      return false;
    } else
      return true;
  }

  bool getStsLogin(String email, String password) =>
      (email.trim().isEmpty || password.trim().isEmpty) ? false : true;
}
