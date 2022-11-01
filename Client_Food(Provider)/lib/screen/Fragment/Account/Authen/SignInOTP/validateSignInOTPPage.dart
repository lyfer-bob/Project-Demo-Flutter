import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:/blocs/login_provider.dart';
import 'package:/screen/Fragment/FragmentProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class ValidateSignInWithOTPPage extends StatefulWidget {
  const ValidateSignInWithOTPPage({Key? key}) : super(key: key);

  @override
  _ValidateSignInWithOTPPageState createState() =>
      _ValidateSignInWithOTPPageState();
}

class _ValidateSignInWithOTPPageState extends State<ValidateSignInWithOTPPage> {
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

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Color(0xFFFEBC18)),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  @override
  void dispose() {
    controller.disposeTimer();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var authBloc = Provider.of<AuthBloc>(context, listen: false);

    return Scaffold(
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
                          child: Consumer<LoginProvider>(
                            builder: (context, pvd, child) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Constants().fontStyleRegular(
                                    'กรุณากรอกหมายเลขยืนยันตัวตน',
                                    fontSize: 24,
                                    colorValue: Colors.black),
                                Constants().fontStyleRegular(
                                    'ที่ส่งไปยังหมายเลข : ${pvd.requestOTPLogin?.result?.phoneNumber ?? ''}',
                                    fontSize: 24,
                                    colorValue: Colors.black),
                                Constants().fontStyleRegular(
                                    '[Ref :${pvd.requestOTPLogin?.result?.pinId ?? ''}]',
                                    fontSize: 24,
                                    colorValue: Colors.black),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 20),
                          child: Pinput(
                            defaultPinTheme: PinTheme(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.only(right: 5),
                            ),
                            keyboardType: TextInputType.phone,
                            submittedPinTheme: PinTheme(
                                textStyle: TextStyle(
                                    fontSize: 25, fontFamily: 'THSarabun'),
                                decoration: _pinPutDecoration),
                            focusNode: _pinPutFocusNode,
                            focusedPinTheme: PinTheme(
                                textStyle: TextStyle(
                                    fontSize: 25, fontFamily: 'THSarabun'),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                )),
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
                          child: Consumer4<LoginProvider, FragmentProvider,
                              AddressSavePageProvider, RestaurantMainProvider>(
                            builder: (context, pvd, pvdFrag, pvdAddres,
                                    pvdRestM, child) =>
                                ButtonAccept(
                              onPressed: () {
                                pvd
                                    .validateSignInWithOTP(
                                  context,
                                  _pinPutController.text,
                                )
                                    .then((value) {
                                  if (pvd.verifyOTPLoginModel!.status == 'OK' &&
                                      pvd.verifyOTPLoginModel!.result!
                                              .success ==
                                          1) {
                                    normalDialog(
                                      context,
                                      '${pvd.verifyOTPLoginModel!.result!.message}',
                                      onPressed: () async {
                                        await pvdFrag.initSigin(context);
                                        await pvdRestM.getDataListMenuMain(
                                            latitude:
                                                pvdAddres.showAddress.latitude,
                                            longitude:
                                                pvdAddres.showAddress.longitude,
                                            context: context,
                                            flagPage: 'MainFlagment');
                                        Navigator.popUntil(context,
                                            ModalRoute.withName('/fragment'));
                                      },
                                    );
                                  } else {
                                    normalDialog(context,
                                        '${pvd.verifyOTPLoginModel!.result!.message}');
                                  }
                                });
                              },
                              text: 'ยืนยัน',
                              fontColor: Colors.white,
                              backgroundColor: Color(0xFFFEBC18),
                              height: 50,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: Consumer<LoginProvider>(
                            builder: (context, pvd, child) => InkWell(
                              onTap: () {
                                if (checkCountdown) {
                                  _pinPutController.clear();
                                  endTime =
                                      DateTime.now().millisecondsSinceEpoch +
                                          Duration(seconds: 60).inMilliseconds;
                                  controller = CountdownTimerController(
                                      endTime: endTime, onEnd: onEnd);

                                  pvd.requestSignInWithOTP(
                                    context,
                                    pvd.requestOTPLogin!.result!.phoneNumber
                                        .toString(),
                                  );
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //     context, '/sendPhoneNumber', (route) => false)
                                  setState(() {
                                    checkCountdown = false;
                                  });
                                }
                              },
                              child: Constants().fontStyleBold(
                                  'ส่งคำขอรหัสใหม่',
                                  fontSize: 24,
                                  colorValue: checkCountdown == false
                                      ? Colors.grey
                                      : Color(0xFFFEBC18)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void onEnd() {
    print('onEnd');
    controller.disposeTimer();
    // controller.dispose();
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
