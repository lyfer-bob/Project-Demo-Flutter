import 'package:minor_digital/utils/core_package.dart';

class RegisterService {
  RegisterService._internal();
  static RegisterService instance = RegisterService._internal();
  factory RegisterService() => instance;

  Future requestToken(TokenGenerate token) async {
    await RestAPI.instance.getToken(ApiPath.getToken, token.toJson());
  }

  Future<RequestOtpModel> requestOtp(RequestOtp requestOtp) async {
    final response =
        await RestAPI.instance.post(ApiPath.getOtp, requestOtp.toJson());

    return RequestOtpModel.fromJson(response);
  }

  Future<RegisterModel> requestRegister(Register register) async {
    final response =
        await RestAPI.instance.post(ApiPath.register, register.toJson());

    return RegisterModel.fromJson(response);
  }
}
