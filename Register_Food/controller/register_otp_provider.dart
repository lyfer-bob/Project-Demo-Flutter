import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/RequestRegisterOTPModel.dart';
import '../models/ValidateRegisterOtpModel.dart';
import '../page/components/Constants.dart';
import 'RigisterStep4_provider.dart';

class RegisterOTPProvider extends ChangeNotifier {
  RegisterOTPProvider();

  TextEditingController phoneController = new TextEditingController();
  TextEditingController validateController = new TextEditingController();

  bool checkBoxValue = false;
  bool checklengthNumberReq = false;
  bool checklengthNumberValidate = false;

  String? _registerREFCODE = '', _registerPINCODE = '';

  DateTime? _registerTIMEEXPIRE;

  RequestRegisterOtpModel? _requestRegisterOtpModel;
  ValidateRegisterOtpModel? _validateRegisterOtpModel;

  init() {
    notifyListeners();
  }

  String get registerREFCODE {
    return _registerREFCODE.toString();
  }

  String get registerPINCODE {
    return _registerPINCODE.toString();
  }

  DateTime? get registerTIMEEXPIRE {
    return _registerTIMEEXPIRE;
  }

  clearDataHolder(String nameController) {
    if (nameController == 'phoneController') {
      phoneController.clear();
    } else if (nameController == 'validateController') {
      validateController.clear();
    }

    notifyListeners();
  }

  setCheckBox(bool value) {
    checkBoxValue = value;
    notifyListeners();
  }

  setlengthNumberReq(bool value) {
    checklengthNumberReq = value;
    notifyListeners();
  }

  setlengthNumberValidate(bool value) {
    checklengthNumberValidate = value;
    notifyListeners();
  }

  Future requestRegisterOTP() async {
    Constants().printColorBlue('requestRegisterOTP:: ${DateTime.now()}');

    String _currentPhoneNo =
        phoneController.text.toString().split('-').join('').toString().trim();

    var body = {
      "phone_number": _currentPhoneNo,
      "otp_type": "RIDER",
      "trans_id": DateTime.now().toString()
    };

    Constants().printColorBlue('requestRegisterOTP_Body:: $body');

    try {
      var jsonData = await RestAPI().postMethod(
        ApiPath().requestRegisterOTP,
        body,
        isxxxxxx: false,
      );

      Constants().printColorBlue('requestRegisterOTP:: $jsonData');

      int isSuccess =
          int.parse(jsonData["response"]["result"]["success"].toString());

      _requestRegisterOtpModel = RequestRegisterOtpModel.fromJson(jsonData);

      Constants().printColorBlue('requestRegisterOTP_isSuccess:: $isSuccess');

      Constants().printColorBlue(
          '_requestRegisterOtpModel_isSuccess:: ${_requestRegisterOtpModel!.response!.result!.success}');

      if (isSuccess == 1) {
        _registerPINCODE =
            _requestRegisterOtpModel!.response!.result!.pinCode.toString();

        _registerREFCODE =
            _requestRegisterOtpModel!.response!.result!.refCode.toString();

        // _registerTIMEEXPIRE = DateTime.parse(
        //     _requestRegisterOtpModel!.response!.result!.otpExpire.toString());

        Constants()
            .printColorBlue('requestRegisterOTP_pin_code:: $_registerPINCODE');

        Constants()
            .printColorBlue('requestRegisterOTP_ref_code:: $_registerREFCODE');

        // Constants().printColorBlue(
        //     'requestRegisterOTP_otp_expire:: $_registerTIMEEXPIRE');

        notifyListeners();
      } else if (isSuccess == 0) {}
    } on Exception catch (exception, stackTrace_ex) {
      Constants().printColorRed(' || CAN NOT CALL REQUEST REGISTER OTP || ');
      Constants().printColorRed('ErrorFrom_requestRegisterOtp:: $exception');
      Constants().printColorRed('check stack error :  $stackTrace_ex');
    } catch (error, stackTrace) {
      Constants().printColorRed(' || CAN NOT CALL REQUEST REGISTER OTP || ');
      Constants().printColorRed('ErrorFrom_requestRegisterOtp:: $error');
      Constants().printColorRed('check stack error :  $stackTrace');

      //orderErrorDialogBackToMainPage(context, 'หมายเลขออเดอร์นี้ถูกยกเลิก');

      //Navigator.popUntil(context, ModalRoute.withName('/mainPage'));
    }
  }

  Future<bool> verifyRegisterOTP(
    BuildContext context,
    String refCodeStr,
    String pinputStr,
  ) async {
    bool status = false;

    Constants().printColorCyan('verifyRegisterOTP:: ${DateTime.now()}');

    String _currentPhoneNo =
        phoneController.text.toString().split('-').join('').toString().trim();

    String _pinputStr = pinputStr;

    Constants().printColorCyan('_currentPhoneNo:: $_currentPhoneNo');

    Constants().printColorCyan(
        'verifyRegisterOTP_Body:: ${phoneController.text.toString().split('-').join('')}');

    var body = {
      "ref_code": _registerREFCODE,
      "pin_code": validateController.text,
      "phone_number": _currentPhoneNo,
      "otp_type": "RIDER",
      "trans_id": DateTime.now().toString()
    };

    Constants().printColorCyan('verifyRegisterOTP_Body:: $body');

    try {
      var jsonData = await RestAPI().postMethod(
        ApiPath().verifyRegisterOTP,
        body,
        isxxxxxx: false,
      );

      Constants().printColorCyan('verifyRegisterOTP:: $jsonData');

      int isSuccess =
          int.parse(jsonData["response"]["result"]["success"].toString());

      _validateRegisterOtpModel = ValidateRegisterOtpModel.fromJson(jsonData);

      Constants().printColorCyan('verifyRegisterOTP_isSuccess:: $isSuccess');

      Constants().printColorCyan(
          '_validateRegisterOtpModel_isSuccess:: ${_validateRegisterOtpModel!.response!.result!.success}');

      if (isSuccess == 1) {
        status = true;
        orderErrorDialog(
          context,
          '${_validateRegisterOtpModel!.response!.result!.message}',
          actionBy: 'noticEvent',
        ).whenComplete(() {
          String getNtPhoneNumber = PreferenceUtils.getNtPhoneNumber() ?? '';

          if (getNtPhoneNumber != _currentPhoneNo) {
            Provider.of<RigisterStep4Provider>(context, listen: false)
                .clearPreference();
          }
          PreferenceUtils.setNtRegisterId(_validateRegisterOtpModel!
              .response!.result!.registerId
              .toString());

          PreferenceUtils.setNtPhoneNumber(_currentPhoneNo);
          Navigator.pushNamed(context, '/registerStep1');
        });

        notifyListeners();
      } else if (isSuccess == 0) {
        status = false;
        orderErrorDialog(
          context,
          '${_validateRegisterOtpModel!.response!.result!.message}',
          actionBy: 'noticEvent',
        );
      }
    } catch (e) {}

    return status;
  }
}
