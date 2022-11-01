import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:/screen/Fragment/Account/Authen/provider/RigisterProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class ValidateRegisterWithOTPPage extends StatefulWidget {
  const ValidateRegisterWithOTPPage({Key? key}) : super(key: key);

  @override
  _ValidateRegisterWithOTPPageState createState() =>
      _ValidateRegisterWithOTPPageState();
}

class _ValidateRegisterWithOTPPageState
    extends State<ValidateRegisterWithOTPPage> {
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
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (BuildContext context, registerProviderValue, Widget? child) =>
          Scaffold(
        backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                headerBar(),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Image.asset(
                        //   'assets/images/lock_ic.png',
                        //   height: 78,
                        //   width: 80,
                        //   fit: BoxFit.fill,
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Constants().fontStyleRegular(
                                  'กรุณากรอกหมายเลข OTP',
                                  fontSize: 24,
                                  colorValue: Colors.black),
                              Constants().fontStyleRegular(
                                  'ที่ส่งไปยังหมายเลข : ${registerProviderValue.requestOTPRegistModel?.result?.phoneNumber ?? ''}',
                                  fontSize: 24,
                                  colorValue: Colors.black),
                              Constants().fontStyleRegular(
                                  '[Ref :${registerProviderValue.requestOTPRegistModel?.result?.pinId ?? ''}]',
                                  fontSize: 24,
                                  colorValue: Colors.black),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: Pinput(
                            defaultPinTheme: PinTheme(
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
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                            focusNode: _pinPutFocusNode,
                            length: 6,
                            controller: _pinPutController,
                            // mainAxisSize: MainAxisSize.min,
                            followingPinTheme: PinTheme(
                                decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
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
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'THSarabun'),
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
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ]));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ButtonAccept(
                            onPressed: () {
                              if (_pinPutController.text.length != 0) {
                                registerProviderValue.validateRegisterWithOTP(
                                    context, _pinPutController.text.toString());

                                // authBloc.validateRegisterWithOTP(
                                //   pinPutCode: _pinPutController.text,
                                //   context: context,
                                // );
                              } else {
                                normalDialog(context, 'กรุณากรอก OTP');
                              }
                            },
                            text: 'ยืนยัน',
                            fontColor: Colors.white,
                            backgroundColor: Color(0xFFFEBC18),
                            height: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: InkWell(
                            onTap: () {
                              if (checkCountdown) {
                                _pinPutController.clear();
                                endTime =
                                    DateTime.now().millisecondsSinceEpoch +
                                        Duration(seconds: 60).inMilliseconds;
                                controller = CountdownTimerController(
                                    endTime: endTime, onEnd: onEnd);

                                registerProviderValue
                                    .requestRegisterWithOTP(context,
                                        registerProviderValue.phoneNoValue)
                                    .then(
                                      (value) => print(
                                          'valueAfterRequestRegisterWithOTP ::::$value'),
                                    );

                                // authBloc.requestRegisterWithOTP(
                                //   phoneOTP: authBloc
                                //       .requestOTPRegistModel!.result!.phoneNumber
                                //       .toString(),
                                //   context: context,
                                // )
                                // Navigator.pushNamedAndRemoveUntil(
                                //     context, '/sendPhoneNumber', (route) => false)
                                setState(() {
                                  checkCountdown = false;
                                });
                              }
                            },
                            child: Constants().fontStyleBold('ส่งคำขอรหัสใหม่',
                                fontSize: 24,
                                colorValue: checkCountdown == false
                                    ? Colors.grey
                                    : Color(0xFFFEBC18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onEnd() {
    print('onEnd');
    controller.disposeTimer();
    setState(() {
      checkCountdown = true;
    });
  }

  Widget headerBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
          color: Color(0xff3D525C), //Filling colour
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(48.0),
          ) //Roundness
          ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () => (Navigator.pop(context)),
                  child: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: logoEatHub(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget logoEatHub() {
    return Image.asset(
      'assets/images/logopng.png',
      height: 150,
      width: 150,
      fit: BoxFit.cover,
    );
  }
}
