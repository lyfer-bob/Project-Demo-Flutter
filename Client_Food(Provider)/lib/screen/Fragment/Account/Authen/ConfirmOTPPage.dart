import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:/blocs/login_provider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class ConfirmOTPPage extends StatefulWidget {
  const ConfirmOTPPage({Key? key}) : super(key: key);

  @override
  _ConfirmOTPPageState createState() => _ConfirmOTPPageState();
}

class _ConfirmOTPPageState extends State<ConfirmOTPPage> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  late CountdownTimerController controller;
  bool checkCountdown = false;
  int endTime = DateTime.now().millisecondsSinceEpoch +
      Duration(seconds: 60).inMilliseconds;

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  @override
  void dispose() {
    controller.disposeTimer();
    controller.dispose();
    super.dispose();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Color(0xFFFEBC18)),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/lock_ic.png',
                      height: 78,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Constants().fontStyleRegular('กรุณากรอกหมายเลข OTP',
                              fontSize: 21),
                          Constants().fontStyleRegular(
                              'ที่ส่งไปยังหมายเลข : ${authBloc.signInModel?.result?.customerPhone ?? ''}',
                              fontSize: 21),
                          Constants().fontStyleRegular(
                              '[Ref : ${authBloc.requestOTPmodel?.result?.pinId ?? ''}]',
                              fontSize: 21),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Pinput(
                        defaultPinTheme: PinTheme(
                          textStyle:
                              TextStyle(fontSize: 25, fontFamily: 'THSarabun'),
                          height: 55,
                          width: 55,
                          margin: EdgeInsets.only(right: 5),
                        ),
                        focusedPinTheme: PinTheme(
                            textStyle: TextStyle(
                                fontSize: 25, fontFamily: 'THSarabun'),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            )),
                        submittedPinTheme: PinTheme(
                            textStyle: TextStyle(
                                fontSize: 25, fontFamily: 'THSarabun'),
                            decoration: _pinPutDecoration.copyWith(
                              borderRadius: BorderRadius.circular(2.0),
                            )),
                        focusNode: _pinPutFocusNode,
                        length: 6,
                        controller: _pinPutController,

                        // mainAxisSize: MainAxisSize.min,
                        followingPinTheme: PinTheme(
                            textStyle: TextStyle(
                                fontSize: 25, fontFamily: 'THSarabun'),
                            decoration: _pinPutDecoration.copyWith(
                              borderRadius: BorderRadius.circular(2.0),
                              border: Border.all(
                                color: Colors.grey.withOpacity(5),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: CountdownTimer(
                          controller: controller,
                          widgetBuilder: (_, CurrentRemainingTime? time) {
                            if (time == null) {
                              return Constants().fontStyleRegular(
                                  'กรุณาลองใหม่อีกครั้ง',
                                  fontSize: 21);
                            }
                            return Text.rich(TextSpan(
                                text: 'กรุณาลองใหม่อีกครั้งใน ',
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: time.min == null ||
                                            time.min.toString().length == 1
                                        ? '00:'
                                        : '${time.min}:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'THSarabun',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text: time.sec.toString().length == 1
                                        ? '0${time.sec} '
                                        : '${time.sec} ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'THSarabun',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'นาที',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'THSarabun',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]));
                            // Constants().fontStyleRegular(
                            //   'กรุณาลองใหม่อีกครั้งใน ${time.min}${time.min} : ${time.sec} นาที',
                            //   fontSize: 21);
                          },
                        ),
                      ),
                    ),
                    ButtonAccept(
                      onPressed: () {
                        authBloc.verifyOTPToAPI(
                            context, _pinPutController.text);
                      },
                      text: 'ยืนยัน',
                      fontColor: Colors.white,
                      backgroundColor: Color(0xFFFEBC18),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {
                          if (checkCountdown) {
                            _pinPutController.clear();
                            endTime = DateTime.now().millisecondsSinceEpoch +
                                Duration(seconds: 60).inMilliseconds;
                            controller = CountdownTimerController(
                                endTime: endTime, onEnd: onEnd);

                            authBloc.requestOTPToAPI(
                              context,
                              authBloc.signInModel!.result!.customerPhone
                                  .toString(),
                            );
                            // Navigator.pushNamedAndRemoveUntil(
                            //     context, '/sendPhoneNumber', (route) => false)

                            setState(() {
                              checkCountdown = false;
                            });
                          }
                        },
                        child: Constants().fontStyleRegular('ขอ OTP อีกครั้ง',
                            fontSize: 21,
                            colorValue: checkCountdown == false
                                ? Colors.grey
                                : Color(0xFFFEBC18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void onEnd() {
    print('onEnd');
    controller.disposeTimer();
    setState(() {
      checkCountdown = true;
    });
  }
}
