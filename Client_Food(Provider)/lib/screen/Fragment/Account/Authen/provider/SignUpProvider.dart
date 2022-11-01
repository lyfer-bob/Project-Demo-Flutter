import 'package:flutter/material.dart';
import 'package:/model/ToJSON/CustomerSignUpModel.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';

class SignUpProvider extends ChangeNotifier {
  SignUpProvider();

  final fname = TextEditingController();
  final lname = TextEditingController();
  final eMail = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final referralCode = TextEditingController();
  final birthday = TextEditingController();

  CustomerSignUpModel? model;
  String? groupValue = '';

  initData() {
    RestAPI()
        .getData(url: ApiPath.customerSignUp, body: model!.toJson())
        .then((value) {
      eMail.text = model!.username!;
      fname.text = model!.firstName!;
      lname.text = model!.lastName!;
      phone.text = model!.phoneNumber!;
      password.text = model!.password!;
      // confirmPassword.text = model!.password!;
      referralCode.text = model!.referralCode!;
      birthday.text = model!.birthday!;
      groupValue = model!.sex! == 'M' ? 'F' : '';

      print('test model ::  ${model!.firstName}');
      notifyListeners();
    });
  }
}
