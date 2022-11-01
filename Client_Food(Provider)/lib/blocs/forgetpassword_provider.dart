import 'package:flutter/material.dart';
import 'package:/model/FromJSON/ForgetPasswordModel.dart';
import 'package:/model/FromJSON/SuccessModel.dart';
import 'package:/model/FromJSON/requestOTPforgotModel.dart';
import 'package:/model/FromJSON/verfityOTPforgotModel.dart';
import 'package:/services/firebaseMessageing.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/DialogsStatus.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  RequestOTPForgotModel? requestOTPForgotModel;
  VerfityOTPForgotModel? verfityOTPForgotModel;
  ForgetPasswordModel? resetPasswordModel;
  SuccessModel? successModel;
  ForgotPasswordProvider();

  Future forgetPasswordWithEmailToAPI(
      BuildContext context, String email) async {
    try {
      var body = {
        "username": email,
      };
      RestAPI().getData(url: ApiPath.forgetPassword, body: body).then(
        (value) {
          resetPasswordModel = ForgetPasswordModel.fromJson(value);
          FirebaseMessageingMethods().subscribeClient(context);
          if (resetPasswordModel!.status == 'OK' &&
              resetPasswordModel!.result!.success == 1) {
            statusDialog(context, '${resetPasswordModel!.result!.message}');
          } else {
            normalDialog(context, '${resetPasswordModel!.result!.message}');
          }
        },
      );
      notifyListeners();
    } catch (e) {
      // normalDialog(context, 'Incorrect \nemail or password');
      print('forgetPasswordWithEmailToAPIError:: $e');
    }
  }

  Future requestOTPForgot(BuildContext context, phoneOTP) async {
    try {
      var preferences = await SharedPreferences.getInstance();
      var body = {"PhoneNumber": "$phoneOTP", "role_id": "3"};
      await RestAPI().getData(url: ApiPath.requestOTPForgot, body: body).then(
        (value) {
          requestOTPForgotModel = RequestOTPForgotModel.fromJson(value);
          FirebaseMessageingMethods().subscribeClient(context);
          preferences.setString(
              'pinCode', requestOTPForgotModel!.result!.pinId.toString());
          preferences.setString('phone', phoneOTP);
          print('phone:: $phoneOTP');
        },
      );
      notifyListeners();
    } catch (e) {
      print('phoneOTPNumber:: $e');
    }
  }

  Future verifyOTPForgot(BuildContext context, String pinPutCode) async {
    try {
      var preferences = await SharedPreferences.getInstance();
      String? phone = preferences.getString('phone');
      var body = {
        "PhoneNumber": phone,
        "role_id": "3",
        "PinID": preferences.getString('pinCode'),
        "PinCode": pinPutCode
      };
      print('phoneOTp:: ${preferences.getString('phone')}');
      print('PinID:: ${preferences.getString('pinCode')}');
      print('PinCode:: $pinPutCode');
      await RestAPI().getData(url: ApiPath.verifyOTPForgot, body: body).then(
        (value) {
          verfityOTPForgotModel = VerfityOTPForgotModel.fromJson(value);
          FirebaseMessageingMethods().subscribeClient(context);
          preferences.setString('id',
              verfityOTPForgotModel!.result!.clientInfo!.customerId.toString());
          // if (verfityOTPForgotModel!.status == 'OK' &&
          //     verfityOTPForgotModel!.result!.success == 1) {
          //   Navigator.pushNamedAndRemoveUntil(
          //       context, '/changePasswordOTPForgot', (route) => false);
          // } else {
          //   normalDialog(context, '${verfityOTPForgotModel!.result!.message}');
          // }
        },
      );
      notifyListeners();
    } catch (e) {
      print('verfityOTPForgot:: $e');
    }
  }

  Future changePasswordOTPForget(
      BuildContext context, String currentPassword, String password) async {
    var preferences = await SharedPreferences.getInstance();
    var cusId = preferences.getString('id');
    try {
      var body = {
        "customer_id": cusId,
        "action": "MyAccount",
        "page": "ChangePassword",
        "currentPassword": currentPassword,
        "password": password
      };
      RestAPI().getData(url: ApiPath.changePassword, body: body).then((value) {
        successModel = SuccessModel.fromJson(value);
        if (successModel!.status == 'OK' &&
            successModel!.result!.success == '1') {
          statusDialog(context, 'เปลี่ยนรหัสผ่านสำเร็จแล้ว');
        } else {
          normalDialog(context, 'รหัสผ่านเก่าไม่ตรงกัน');
        }
      });
      notifyListeners();
    } catch (e) {
      // normalDialog(context, '$e');
      print('sendChangePassword:: $e');
    }
  }
}
