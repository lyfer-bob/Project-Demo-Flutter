import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:/model/FromJSON/CustomerLoginModel.dart';
import 'package:/model/FromJSON/SocialLoginModel.dart';
import 'package:/model/FromJSON/SuccessModel.dart';
import 'package:/model/FromJSON/requestOTPRegistModel.dart';
import 'package:/model/FromJSON/verifyOTPRegistRodel.dart';
import 'package:/screen/Fragment/FragmentProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/screen/Profile/provider/ProfileCustomerProvider.dart';
import 'package:/services/auth_service.dart';
import 'package:/services/firebaseMessageing.dart';
import 'package:/services/firebase_log.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsStatus.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterProvider extends ChangeNotifier {
  RegisterProvider();

  final authService = AuthService();

  GoogleSignIn _googleSignIn = GoogleSignIn();

  CustomerLoginModel? signInModel;

  RequestOTPRegistModel? requestOTPRegistModel;

  VerifyOTPRegistModel? verifyOTPRegistModel;

  SuccessModel? successModel;

  SocialLoginModel? socialLoginModel;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String _email = '',
      _passWord = '',
      _confirmPassword = '',
      gender = 'NA',
      _birthday = '',
      _phoneNo = '';

  get emailValue {
    return _email.toString();
  }

  setEmailValue(String value) {
    _email = value;

    notifyListeners();
  }

  get passWordValue {
    return _passWord.toString();
  }

  setPassWordValue(String value) {
    _passWord = value;

    passwordController.clear();

    print('_passWord:: $_passWord');

    notifyListeners();
  }

  get confirmPasswordValue {
    return _confirmPassword.toString();
  }

  setConfirmPasswordValue(String value) {
    _confirmPassword = value;

    confirmPasswordController.clear();

    print('_confirmPassword:: $_confirmPassword');

    notifyListeners();
  }

  get genderValue {
    return gender.toString();
  }

  setGenderValue(String value) {
    gender = value;

    print('Set_gender:: $gender');
    notifyListeners();
  }

  get birthdayValue {
    return _birthday.toString();
  }

  setBirthdayValue(String value) {
    _birthday = value;

    notifyListeners();
  }

  get phoneNoValue {
    return _phoneNo.toString();
  }

  setPhoneNoValue(String value) {
    _phoneNo = value;

    notifyListeners();
  }

  Future<Null> sendCreateUserAPI(BuildContext context,
      {String? email,
      password,
      gender,
      firstname,
      lastname,
      phone,
      referralCode,
      birthday}) async {
    try {
      setEmailValue(email!);
      setPassWordValue(password);
      setConfirmPasswordValue(password);
      setGenderValue(gender);
      setPhoneNoValue(phone);

      var body = {
        "username": email,
        "first_name": firstname,
        "last_name": lastname,
        "password": password,
        "phone_number": phone,
        "referral_code": referralCode,
        "gender": gender == "NA" || gender == "" ? null : gender,
        "date_of_birth": birthday,
      };

      RestAPI().getData(url: ApiPath.customerSignUp, body: body).then(
        (value) {
          print("JSON DATA SIGN UP ::: $value :::::");

          successModel = SuccessModel.fromJson(value);

          if (successModel!.status == 'OK' &&
              successModel!.result!.success == '1') {
            if (successModel!.result!.verifyotp == '0') {
              statusDialog(
                  context,
                  successModel!.result!.message.toString() +
                      '\n*ก่อนเข้าสู่ระบบกรุณา "กดยืนยัน" ในอีเมลล์ก่อน');
            } else {
              requestRegisterWithOTP(context, phone).then(
                (value) =>
                    Navigator.pushNamed(context, '/validateRegisterWithOTP'),
              );
            }
            notifyListeners();
          } else {
            statusRegisterDialog(
                    context, successModel!.result!.message.toString())
                .then(
              (value) {
                // setPassWordValue('');
                // setConfirmPasswordValue('');
              },
            );
          }
        },
      );
    } on Exception catch (exception, stackTrace_ex) {
      Constants().printColorRed('|||| on Exception catch ||||');
      Constants().printColorRed('ErrorFromCustomerSignUp:: $exception');
      Constants().printColorRed('check stack error :  $stackTrace_ex');
    } catch (error) {
      // normalDialog(context, '$e');
      print('ErrorFromCustomerSignUp:: $error');
    }
  }

  Future<Null> requestRegisterWithOTP(
      BuildContext context, String? phoneOTP) async {
    try {
      var preferences = await SharedPreferences.getInstance();

      var body = {
        "PhoneNumber": phoneOTP,
        "role_id": "3",
      };

      await RestAPI().getData(url: ApiPath.requestOTPRegister, body: body).then(
        (value) {
          requestOTPRegistModel = RequestOTPRegistModel.fromJson(value);

          preferences.setString(
              'pinCode', requestOTPRegistModel!.result!.pinId.toString());

          preferences.setString('phone', phoneOTP.toString());

          print('phone:: $phoneOTP');

          if (requestOTPRegistModel!.status == 'OK' &&
              requestOTPRegistModel!.result!.success == 1) {
            // Navigator.pushNamed(context, '/validateRegisterWithOTP');

            notifyListeners();
          } else {
            normalDialog(context, 'กรุณากรอกหมายเลขให้ถูกต้อง');
          }
        },
      );
    } on Exception catch (exception, stackTrace_ex) {
      Constants().printColorRed('|||| on Exception catch ||||');
      Constants().printColorRed('ErrorFromRequestOTPRegister:: $exception');
      Constants().printColorRed('check stack error :  $stackTrace_ex');
    } catch (error) {
      // normalDialog(context, '$e');
      print('ErrorFromRequestOTPRegister:: $error');
    }
  }

  Future<Null> validateRegisterWithOTP(
      BuildContext context, String? pinPutCode) async {
    try {
      var preferences = await SharedPreferences.getInstance();

      var body = {
        "PhoneNumber": preferences.getString('phone'),
        "role_id": "3",
        "PinID": preferences.getString('pinCode'),
        "PinCode": pinPutCode,
        "device_name": preferences.getString('platform'),
        "device_id": preferences.getString('deviceId')
      };

      await RestAPI().getData(url: ApiPath.verifyOTPRegister, body: body).then(
        (value) {
          verifyOTPRegistModel = VerifyOTPRegistModel.fromJson(value);

          if (verifyOTPRegistModel!.status == 'OK' &&
              verifyOTPRegistModel!.result!.success == 1) {
            FirebaseMessageingMethods().subscribeClient(context);

            statusDialog(
                context, verifyOTPRegistModel!.result!.message.toString());

            notifyListeners();
          } else {
            normalDialog(context, '${verifyOTPRegistModel!.result!.message}');
          }
        },
      );
    } on Exception catch (exception, stackTrace_ex) {
      Constants().printColorRed('|||| on Exception catch ||||');
      Constants().printColorRed('ErrorFromVerifyOTPRegister:: $exception');
      Constants().printColorRed('check stack error :  $stackTrace_ex');
    } catch (error) {
      // normalDialog(context, '$e');
      print('ErrorFromVerifyOTPRegister:: $error');
    }
  }

  Future<Null> sendCreateUserThirdParty({
    @required context,
    @required email,
    @required firstname,
    @required lastname,
  }) async {
    firstname ??= '';
    lastname ??= '';

    try {
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

      var body = {
        "username": email,
        "device_type": platform,
        "device_id": deviceId,
        "first_name":
            firstname.toString() != 'null' || firstname.toString().isNotEmpty
                ? firstname.toString()
                : '',
        "last_name":
            lastname.toString() != 'null' || lastname.toString().isNotEmpty
                ? lastname.toString()
                : ''
      };

      print('REQUEST_value:: $body');

      await RestAPI()
          .getData(
        url: ApiPath.socialSignUp,
        body: body,
      )
          .then(
        (value) async {
          print('JSON_value:: $value');

          socialLoginModel = SocialLoginModel.fromJson(value);

          print(
              '\x1B[33m|||| userID ${socialLoginModel!.result!.customerId.toString()} ||||\x1B[0m');
          print(
              '\x1B[33m|||| custDeviceId ${socialLoginModel!.result!.custDeviceId.toString()} ||||\x1B[0m');

          preferences.setString('idEmail', email);
          preferences.setString(
              'id', socialLoginModel!.result!.customerId.toString());
          preferences.setString('custDeviceId',
              socialLoginModel!.result!.custDeviceId.toString());
          preferences.setString(
              'phone', socialLoginModel!.result!.customerPhone.toString());

          //print('socialLoginModel $value ->> $body');

          print("socialLoginModel status  ->> ${socialLoginModel!.status}");
          print("socialLoginModel name ->> ${socialLoginModel!.result!.name}");
          print(
              "socialLoginModel customerPhone ->> ${socialLoginModel!.result!.customerPhone!.isEmpty}");

          if (socialLoginModel!.status == 'OK' &&
              socialLoginModel!.result!.success == '1') {
            Provider.of<ProfileCustomerProvider>(context, listen: false)
                .setSocialLogInBool(true);

            await Provider.of<FragmentProvider>(context, listen: false)
                .initSigninSocail(context);

            Provider.of<RestaurantMainProvider>(context, listen: false)
                .getDataListMenuMain(
                    context: context, flagPage: 'MainFlagment');

            if (socialLoginModel!.result!.customerPhone!.isEmpty) {
              print('socialLogin is success but phonenumber is empty');

              loginThirdPartyDialog(
                  context, '${socialLoginModel!.result!.message.toString()}');

              //Navigator.pushNamed(context, '/profile');
            } else {
              print('socialLogin is success and have phonenumber');

              FirebaseMessageingMethods().subscribeClient(context!);

              dialogSignInSusses(
                  context, '${socialLoginModel!.result!.message.toString()}');

              print(
                  'socialLoginModel :: ${socialLoginModel!.result!.message.toString()}');

              FirebaseMessageingMethods().subscribeClient(context);

              //String? _userID = preferences.getString('id').toString();

            }
          } else {
            normalDialog(context, socialLoginModel!.result!.message.toString());
            // Navigator.pushNamedAndRemoveUntil(
            //     context, '/fragment', (route) => false);
          }
        },
      );
    } on Exception catch (exception, stackTrace_ex) {
      Constants().printColorRed('|||| on Exception catch ||||');
      Constants().printColorRed('ErrorFromGetFullDetailFromAPI:: $exception');
      Constants().printColorRed('check stack error :  $stackTrace_ex');
    } catch (error) {
      // normalDialog(context, '$e');
      print('sendCreateUserThirdPartyError:: $error');
    }
  }

  Future<Null> sendSignOutAPI(BuildContext context) async {
    print('sendSignOutAPI');

    var preferences = await SharedPreferences.getInstance();

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    String? platform, deviceId, customerID, cusDeviceId;
    customerID = preferences.getString('id');
    cusDeviceId = preferences.getString('custDeviceId');
    bool? isLogin = preferences.getBool('stsLogin');

    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      platform = 'android';
      deviceId = build.androidId.toString();
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      platform = 'ios';
      deviceId = data.identifierForVendor.toString();
    }

    print('\x1B[33m$isLogin\x1B[0m');
    print('\x1B[33m$customerID\x1B[0m');
    print('\x1B[33m$cusDeviceId\x1B[0m');
    print('\x1B[33m$deviceId\x1B[0m');
    print('\x1B[33m$platform\x1B[0m');
    var body = {
      "customer_id": customerID,
      "device_type": platform,
      "device_id": deviceId,
      "custDeviceId": cusDeviceId
    };
    try {
      authService.signOut().then(
        (value) async {
          _googleSignIn.signOut();

          print('\x1B[36m$body\x1B[0m');

          await RestAPI().getData(url: ApiPath.logout, body: body).then(
            (value) async {
              print('JSONSignOutAPI:: $value');

              // if (value["result"]["success"].toString() == '1') {
              FirebaseMessageingMethods().unSubscribeClient(context);

              Provider.of<ProfileCustomerProvider>(context, listen: false)
                  .setSocialLogInBool(false);

              await Provider.of<FragmentProvider>(context, listen: false)
                  .onClickSingout(context);

              Navigator.popUntil(context, ModalRoute.withName('/fragment'));

              await Provider.of<AddressSavePageProvider>(context, listen: false)
                  .clearAddressLogout(context);
              // }
            },
          );
        },
      );
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'logout',
          body: '$body',
          clientID: customerID,
          restData: 'logout success');
    } on Exception catch (exception) {
      // Constants().printColorRed('|||| on Exception catch ||||');
      // Constants().printColorRed('ErrorFromSignOut:: $exception');
      // Constants().printColorRed('check stack error :  $stackTrace_ex');
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'logout',
          body: '$body',
          clientID: customerID,
          restData: '$exception');
    } catch (error) {
      // normalDialog(context, '$e');
      print('ErrorFromSignOut:: $error');
      FirebaseLog().addLogDataToFirebase(
          actionBy: 'logout',
          body: '$body',
          clientID: customerID,
          restData: '$error');
    }
  }
}
