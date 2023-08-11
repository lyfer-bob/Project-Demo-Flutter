import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:minor_digital/controllers/regeister_controller.dart';
import 'package:minor_digital/utils/core_package.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPage();
}

class _OtpPage extends State<OtpPage> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    int reduceSecondsBy = 1;

    int seconds = 0;

    setState(() {
      seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        // * when expired
        warningDialog();
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  warningDialog() {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.warning,
      title: 'Warning!',
      desc: 'OTP expired. Would you like to get OTP again?',
      dismissOnBackKeyPress: false,
      dismissOnTouchOutside: false,
      btnOkOnPress: () {
        context
            .read<RegisterController>()
            .requestOTP(context, refreshOTP: true);
      },
      btnCancelOnPress: () {
        setState(() => countdownTimer!.cancel());
        Navigator.popUntil(context, ModalRoute.withName(Routes.register));
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
        body: Consumer<RegisterController>(builder: (context, regist, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'OTP Verification',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 35, color: Colors.blue),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15),
            child: Text(
              'Ref. Code : ${regist.modelOtp.refCode}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'OTP : ${regist.modelOtp.otp}',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          OtpTextField(
            numberOfFields: 6,
            styles: const [
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ],
            borderColor: Colors.blue,
            focusedBorderColor: Colors.blue,
            showFieldAsBox: true,
            clearText: true,
            onSubmit: (String verificationCode) {
              setState(() => countdownTimer!.cancel());
              regist.verifyOTP(verificationCode, context);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 20),
            child: Text(
              'Expire in : $minutes:$seconds',
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 245, 25, 9)),
            ),
          ),
        ],
      );
    }));
  }
}
