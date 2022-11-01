import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:/blocs/auth_bloc.dart';
import 'package:/model/FromJSON/CustomerLoginModel.dart';
import 'package:/model/FromJSON/SuccessModel.dart';
import 'package:/model/FromJSON/requestOTPLoginModel.dart';
import 'package:/model/FromJSON/requestOTPmedel.dart';
import 'package:/model/FromJSON/verifyOTPLoginModel.dart';
import 'package:/services/firebaseMessageing.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  CustomerLoginModel? signInModel;
  RequestOTPMedel? requestOTPmodel;
  SuccessModel? successModel;
  RequestOTPLoginModel? requestOTPLogin;
  VerifyOTPLoginModel? verifyOTPLoginModel;

  LoginProvider();

  Future sendLogInWithEmailToAPI(
      {BuildContext? context,
      String? email,
      String? password,
      String? deviceType,
      String? deviceID}) async {
    var preferences = await SharedPreferences.getInstance();

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    String? platform, deviceId;

    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      platform = 'android';
      deviceId = build.androidId.toString();
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      platform = 'ios';
      deviceId = data.identifierForVendor.toString();
    }

    try {
      var body = {
        "username": email,
        "password": password,
        "device_type": platform,
        "device_id": deviceId,
        "role_id": "3"
      };

      print('REQUESTcustomerLogin:: $body');

      RestAPI().getData(url: ApiPath.customerLogin, body: body).then(
        (value) {
          print('JSONcustomerLogin::: $value');

          if (value['result']['success'] == 1) {
            signInModel = CustomerLoginModel.fromJson(value);
            preferences.setString(
                'id', signInModel!.result!.customerId.toString());
            preferences.setString(
                'phone', signInModel!.result!.customerPhone.toString());
            preferences.setString(
                'email', signInModel!.result!.email.toString());
            preferences.setString('passWord', password.toString());
            preferences.setString(
                'custDeviceId', signInModel!.result!.custDeviceId.toString());
            print(
                'custDeviceId :::: ${signInModel!.result!.custDeviceId.toString()}');

            if (signInModel!.result!.otp == null ||
                signInModel!.result!.otp!.isEmpty) {
              requestOTPToAPI(
                      context!, signInModel!.result!.customerPhone.toString())
                  .then((value) {
                if (requestOTPmodel!.result!.success == 1) {
                  Navigator.pushNamed(context, '/confirmOTP');
                }
              });
              // Navigator.pushNamedAndRemoveUntil(
              //     context, '/sendPhoneNumber', (route) => false);
            } else {
              FirebaseMessageingMethods().subscribeClient(context!);

              AuthBloc().dialogSignInSusses(
                  context, signInModel!.result!.message.toString());
            }
          } else {
            print(value);
            normalDialog(context!, '${value['result']['message']}');
          }
        },
      );
      notifyListeners();
    } catch (e) {
      // normalDialog(context!, 'Incorrect email or password');
      print('ErrorFromSignInWithEmail:: $e');
    }
  }

  Future requestOTPToAPI(BuildContext context, String phoneOTP) async {
    try {
      var preferences = await SharedPreferences.getInstance();
      var body = {
        "PhoneNumber": phoneOTP,
      };
      await RestAPI().getData(url: ApiPath.requestOTP, body: body).then(
        (value) {
          requestOTPmodel = RequestOTPMedel.fromJson(value);
          // FirebaseMessageingMethods().subscribeClient(context);

          if (requestOTPmodel!.status == 'OK' &&
              requestOTPmodel!.result!.success == 1) {
            // Navigator.pushNamedAndRemoveUntil(
            //     context, '/confirmOTP', (route) => false);
            preferences.setString(
                'pinID', requestOTPmodel!.result!.pinId.toString());
          } else {
            normalDialog(context, '${value['result']['message']}');
          }
        },
      );
      notifyListeners();
    } catch (e) {
      print('requestOTPToAPI:: $e');
    }
  }

  Future verifyOTPToAPI(BuildContext context, String pinCode) async {
    try {
      var preferences = await SharedPreferences.getInstance();
      preferences.getString('email');
      var body = {
        "username": preferences.getString('email'),
        "PinID": preferences.getString('pinID'),
        "PinCode": pinCode
      };
      await RestAPI().getData(url: ApiPath.verifyOTP, body: body).then(
        (value) {
          successModel = SuccessModel.fromJson(value);
          FirebaseMessageingMethods().subscribeClient(context);
          if (successModel!.status == 'OK' &&
              successModel!.result!.success == '1') {
            AuthBloc().dialogSignInSusses(
                context, successModel!.result!.message.toString());
          } else {
            normalDialog(context, '${value['result']['message']}');
          }
        },
      );
      notifyListeners();
    } catch (e) {
      print('verifyOTPToAPI:: $e');
    }
  }

  Future requestSignInWithOTP(BuildContext context, String phoneOTP) async {
    try {
      var preferences = await SharedPreferences.getInstance();
      var body = {
        "PhoneNumber": phoneOTP,
        "role_id": "3",
      };
      await RestAPI().getData(url: ApiPath.requestOTPLogin, body: body).then(
        (value) {
          requestOTPLogin = RequestOTPLoginModel.fromJson(value);
          FirebaseMessageingMethods().subscribeClient(context);
          preferences.setString(
              'pinCode', requestOTPLogin!.result!.pinId.toString());
          preferences.setString('phone', phoneOTP);
          print('phone:: $phoneOTP');

          if (requestOTPLogin!.status == 'OK' &&
              requestOTPLogin!.result!.success == 1) {
            // Navigator.pushNamed(context, '/validateSignInWithOTP');
          } else {
            normalDialog(context, 'กรุณากรอกหมายเลขให้ถูกต้อง');
          }
        },
      );
      notifyListeners();
    } catch (e) {
      print('requestSignInWithOTP:: $e');
    }
  }

  Future validateSignInWithOTP(BuildContext context, String pinPutCode) async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    var preferences = await SharedPreferences.getInstance();
    String? platform, deviceId, phone, pinId;

    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      platform = 'android';
      deviceId = build.androidId.toString();
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      platform = 'ios';
      deviceId = data.identifierForVendor.toString();
    }
    phone = preferences.getString('phone');
    pinId = preferences.getString('pinCode');

    try {
      var body = {
        "PhoneNumber": phone,
        "role_id": "3",
        "PinID": pinId,
        "PinCode": pinPutCode,
        "device_name": platform,
        "device_id": deviceId
      };
      await RestAPI()
          .getData(url: ApiPath.verifyOTPLogin, body: body)
          .then((value) {
        verifyOTPLoginModel = VerifyOTPLoginModel.fromJson(value);
        FirebaseMessageingMethods().subscribeClient(context);
        preferences.setString('id',
            verifyOTPLoginModel!.result!.clientInfo!.customerId.toString());

        preferences.setString('custDeviceId',
            verifyOTPLoginModel!.result!.clientInfo!.custDeviceId.toString());
        print(
            'custDeviceId :::: ${verifyOTPLoginModel!.result!.clientInfo!.custDeviceId.toString()}');
        print(
            'Id :::: ${verifyOTPLoginModel!.result!.clientInfo!.customerId.toString()}');
      });
      notifyListeners();
    } catch (e) {
      print('verifyOTPLogin:: $e');
    }
  }
}
