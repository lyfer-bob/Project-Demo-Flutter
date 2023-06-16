import '../controllers/pagekage.dart';

class LoginRepository {
  LoginRepository._internal();
  static LoginRepository _instance = LoginRepository._internal();
  factory LoginRepository() => _instance;

  Future<LoginModel> requestLogin(Login login) async {
    login.deviceId = DataStorage.getDeviceName() ?? '';
    login.deviceName = DataStorage.getPlatform() ?? '';
    login.deviceOs = 'iOS 15.6.1';

    final response =
        await APIProvider.instance.post(ApiPath.login, login.toJson());

    return LoginModel.fromJson(response);
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
