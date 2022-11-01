import 'package:flutter/material.dart';
import 'package:/model/FromJSON/CustomerDetailsModel.dart';
import 'package:/model/FromJSON/SuccessModel.dart';
import 'package:/model/FromJSON/requestOTPRegistModel.dart';
import 'package:/model/FromJSON/verifyOTPRegistRodel.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCustomerProvider extends ChangeNotifier {
  ProfileCustomerProvider();

  CustomerDetailsModel? model;

  final name = TextEditingController();
  final surname = TextEditingController();
  final eMail = TextEditingController();
  final phone = TextEditingController();
  final birthday = TextEditingController();

  String? _name = '',
      _lastName = '',
      _eMail = '',
      _phoneNo = '',
      _gender = 'NA',
      labelError = '';

  bool _havePhoneNo = false, _isSocialLogIn = false, checkSuccessOTP = false;
  RequestOTPRegistModel? requestOTPRegistModel;
  VerifyOTPRegistModel? verifyOTPRegistModel;

  get nameUser {
    return _name.toString();
  }

  get lastNameUser {
    return _lastName.toString();
  }

  get eMailUser {
    return _eMail.toString();
  }

  get phoneNoUser {
    return _phoneNo.toString();
  }

  get havePhoneNoBool {
    return _havePhoneNo;
  }

  get genderUser {
    return _gender.toString();
  }

  setGenderUser(String? value) {
    _gender = value.toString();

    notifyListeners();
  }

  setUserNameValue() {
    _name = name.text.toString();

    notifyListeners();
  }

  setLastNameValue() {
    _lastName = surname.text.toString();

    notifyListeners();
  }

  setPhoneValue() {
    _phoneNo = phone.text.toString();

    notifyListeners();
  }

  get socialLogInBool {
    return _isSocialLogIn;
  }

  setSocialLogInBool(bool value) {
    _isSocialLogIn = value;

    notifyListeners();
  }

  // String firebaseUserType = '';

  initData(BuildContext context) async {
    var preferences = await SharedPreferences.getInstance();
    var customerId = preferences.getString('id');

    var body = {
      "customer_id": customerId,
      "action": "MyAccount",
      "page": "CustomerDetails"
    };
    RestAPI().getData(url: ApiPath.customerDetails, body: body).then(
      (value) {
        model = CustomerDetailsModel.fromJson(value);
        // preferences.setString('phone', model!.result!.customerPhone.toString() );
        // print('va >.>> >>$value ');

        if (model!.result!.success == '1') {
          _name = model!.result!.firstName.toString() != 'null'
              ? model!.result!.firstName
              : '';
          _lastName = model!.result!.lastName.toString() != 'null'
              ? model!.result!.lastName
              : '';
          _eMail = model!.result!.email.toString() != 'null'
              ? model!.result!.email
              : '';
          _phoneNo = model!.result!.customerPhone.toString() != 'null'
              ? model!.result!.customerPhone
              : '';
          _gender = model!.result!.sex.toString() != 'null'
              ? model!.result!.sex
              : 'NA';

          print(_phoneNo!.length);

          _phoneNo!.length == 10 ? _havePhoneNo = true : _havePhoneNo = false;

          Constants().printColorGreen(
              'UserBirthDay::: ${model!.result!.birthday.toString()}');

          model!.result!.birthday.toString() != 'null'
              ? birthday.text = model!.result!.birthday.toString()
              : birthday.text = '';

          name.text = _name.toString();
          surname.text = _lastName.toString();
          eMail.text = _eMail.toString();
          phone.text = _phoneNo.toString();
        } else {
          _name = '';
          _lastName = '';
          _eMail = '';
          _phoneNo = '';
          _gender = 'NA';
        }

        //notifyListeners();
      },
    );
  }

  setLabelErrorOTP(String label) {
    labelError = label;
    notifyListeners();
  }

  Future<Null> requestRegisterWithOTP(
      BuildContext context, String? phoneOTP) async {
    var preferences = await SharedPreferences.getInstance();
    var customerId = preferences.getString('id');
    print(customerId);
    try {
      var body = {
        "phone": phoneOTP,
        "customer_id": "$customerId",
      };

      await RestAPI()
          .getData(url: ApiPath.requestOTPProfileUpdate, body: body)
          .then(
        (value) {
          // Constants().printColorGreen('tttttttttttttttttttttttttttttttttttttttttt');
          Constants().printColorGreen(value.toString());
          requestOTPRegistModel = RequestOTPRegistModel.fromJson(value);

          if (requestOTPRegistModel!.status == 'OK' &&
              requestOTPRegistModel!.result!.success == 1) {
            // Navigator.pushNamed(context, '/validateRegisterWithOTP');
            Constants()
                .printColorCyan('${requestOTPRegistModel!.result!.pinId}');

            notifyListeners();
          } else {
            // normalDialog(context, 'กรุณากรอกหมายเลขให้ถูกต้อง');
            Constants().dialogProgress(context, pop: true);
            normalDialog(
                context,
                value['result']['message'] != null
                    ? value['result']['message']
                    : 'An Internal Error Has Occurred.');
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

  Future<Null> validateRegisterWithOTP(BuildContext context,
      {String? pinCode}) async {
    var preferences = await SharedPreferences.getInstance();
    var customerId = preferences.getString('id');
    try {
      var body = {
        "PinID": '${requestOTPRegistModel!.result!.pinId}',
        "PinCode": '$pinCode',
        "PhoneNumber": '${requestOTPRegistModel!.result!.phoneNumber}',
        "customer_id": "$customerId",
      };

      await RestAPI()
          .getData(url: ApiPath.verfityOTPProfileUpdate, body: body)
          .then(
        (value) {
          verifyOTPRegistModel = VerifyOTPRegistModel.fromJson(value);

          if (verifyOTPRegistModel!.status == 'OK' &&
              verifyOTPRegistModel!.result!.success == 1) {
            checkSuccessOTP = true;
            setLabelErrorOTP('${verifyOTPRegistModel!.result!.message}');
          } else {
            checkSuccessOTP = false;
            setLabelErrorOTP('${verifyOTPRegistModel!.result!.message}');
            // normalDialog(context, '${verifyOTPRegistModel!.result!.message}');
          }
        },
      );
      notifyListeners();
    } on Exception catch (exception, stackTrace_ex) {
      Constants().printColorRed('|||| on Exception catch ||||');
      Constants().printColorRed('ErrorFromVerifyOTPRegister:: $exception');
      Constants().printColorRed('check stack error :  $stackTrace_ex');
    } catch (error) {
      // normalDialog(context, '$e');
      print('ErrorFromVerifyOTPRegister:: $error');
    }
  }

  Future<Null> sendProfileUpdate(
    BuildContext context, {
    String? gender,
    email,
    firstname,
    lastname,
    phone,
    birthday,
  }) async {
    try {
      var preferences = await SharedPreferences.getInstance();
      var customerId = preferences.getString('id');

      var body = {
        "customer_id": customerId,
        "action": "MyAccount",
        "page": "ProfileUpdate",
        "email": email,
        "first_name": firstname,
        "last_name": lastname,
        "phone": phone,
        "sex": gender == "NA" || gender == "" ? null : gender,
        "birthday": birthday!.length == 0 ? null : birthday,
      };
      RestAPI().getData(url: ApiPath.profileUpdate, body: body).then(
        (value) {
          var successModel = SuccessModel.fromJson(value);
          print('KKK >.>>$body >>$value ');

          if (successModel.status == 'OK' &&
              successModel.result!.success.toString() == '1') {
            preferences.setString('phone', phone);

            normalDialog(context, successModel.result!.message.toString(),
                onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/fragment'));
            });
          } else {
            normalDialog(
                context,
                successModel.result!.message != null
                    ? successModel.result!.message.toString()
                    : 'An Internal Error Has Occurred.');
          }
          notifyListeners();
          initData(context);
        },
      );
    } catch (e) {
      normalDialog(context, '$e');
      print('ErrorFromSignInWithEmail:: $e');
    }
  }
}
