import 'package:minor_digital/services/register_service.dart';
import 'package:minor_digital/utils/core_package.dart';

class RegisterController extends ChangeNotifier {
  RegisterController();

  RegisterService registService = RegisterService();

  final fname = TextEditingController();
  final lname = TextEditingController();
  final mobile = TextEditingController();

  bool fnameSts = true;
  bool lnameSts = true;
  bool mobileSts = true;
  bool isSubmit = false;

  String errorTextMobile = '';

  var registModel = RegisterModel();
  var registRequest = Register();

  var requestOtp = RequestOtp();
  var modelOtp = RequestOtpModel();

  var tokenRequest = TokenGenerate();

  var log = Logger();

  init() async {
    fnameSts = false;
    lnameSts = false;
    mobileSts = false;
  }

  void submitRegist(BuildContext context) {
    if (fname.text.trim().isEmpty) fnameSts = true;

    if (lname.text.trim().isEmpty) lnameSts = true;

    if (mobile.text.trim().isEmpty) {
      mobileSts = true;
      errorTextMobile = 'Please fill in this form.';
    } else if (mobile.text.length < 10) {
      mobileSts = true;
      errorTextMobile = 'Please complete the number.';
    } else if (mobile.text[0] != '0') {
      mobileSts = true;
      errorTextMobile = 'Please enter a valid phone number.';
    }

    if (!fnameSts && !lnameSts && !mobileSts) {
      requestOTP(context);
    }

    notifyListeners();
  }

  void onChangeTextFieldRegist(String flag) {
    if (flag == 'First Name' && fname.text.isNotEmpty && fnameSts) {
      fnameSts = false;
      notifyListeners();
    }

    if (flag == 'Last Name' && lname.text.isNotEmpty && lnameSts) {
      lnameSts = false;
      notifyListeners();
    }

    if (flag == 'Mobile' && mobileSts && mobile.text.isNotEmpty) {
      mobileSts = false;
      notifyListeners();
    }
  }

  Future getToken() async {
    try {
      // Todo: set data before call api

      tokenRequest.expiredInDay = 24;
      tokenRequest.refId = 'asdfafdsdfwoerowdksfksfjdsf';

      // Todo : call apis
      await registService.requestToken(tokenRequest);
    } catch (e) {
      debugPrint('error get getToken $e');
    }
  }

  Future requestOTP(BuildContext context, {bool refreshOTP = false}) async {
    try {
      requestOtp.firstName = fname.text;
      requestOtp.lastName = lname.text;
      requestOtp.mobileTel = mobile.text;
      modelOtp = await registService.requestOtp(requestOtp);

      !refreshOTP
          ? Navigator.pushNamed(context, Routes.otpPage)
          : Navigator.pushReplacementNamed(context, Routes.otpPage);
    } catch (e) {
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.error,
        title: 'Error!',
        desc: '$e',
      ).show();

      log.e('error get otp $e');
    }
    notifyListeners();
  }

  Future verifyOTP(String otpValue, BuildContext context) async {
    try {
      // Todo: set data before call api
      registRequest.firstName = fname.text;
      registRequest.lastName = lname.text;
      registRequest.mobileTel = mobile.text;
      registRequest.refCode = modelOtp.refCode;
      registRequest.otp = otpValue;

      // Todo : call api check otp

      registModel = await registService.requestRegister(registRequest);

      if (registModel.isValid!) {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          title: 'Message',
          desc: 'Congratulations your account has been created.',
          onDismissCallback: (_) =>
              Navigator.pushNamed(context, Routes.successPage),
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          title: 'Error!',
          desc: 'OTP does not match.',
          onDismissCallback: (_) =>
              Navigator.pushReplacementNamed(context, Routes.otpPage),
        ).show();
      }
    } catch (e) {
      debugPrint('error get onRegister $e');
    }
    notifyListeners();
  }

  bool stsSubmitcheck() => (!fnameSts && !fnameSts && !mobileSts);
}
