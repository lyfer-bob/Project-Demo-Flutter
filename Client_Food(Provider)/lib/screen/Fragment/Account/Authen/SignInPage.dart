import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:/blocs/auth_bloc.dart';
import 'package:/blocs/login_provider.dart';
import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:/screen/Fragment/FragmentProvider.dart';
import 'package:/services/auth_service.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailStrControl = TextEditingController();
  final passwordStrControl = TextEditingController();

  Stream<User?> get currentUser => AuthService().currentUser;
  bool _obscureText = true;
  bool _checkedValue = false;
  var valueCheck;

  @override
  void initState() {
    super.initState();

    Provider.of<FragmentProvider>(context, listen: false)
        .initKeyboardCheckBasketIcon();

    checkRemember();
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    authBloc.currentUser.listen((firebaseUser) {
      if (firebaseUser != null) {
        print('FirebaseUser:: ${firebaseUser.providerData[0].providerId}');
      } else {
        print('NO FirebaseUser');
      }
    });
  }

  checkRemember() async {
    var preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('valueCheck') == true) {
      setState(() {
        emailStrControl.text = preferences.getString('email').toString();
        passwordStrControl.text = preferences.getString('passWord').toString();
        _checkedValue = true;
      });
    } else {
      emailStrControl.text = '';
      _checkedValue = false;
    }
  }

  // @override
  // void dispose() {
  //   Provider.of<FragmentProvider>(context, listen: false)
  //       .disposeKeyBoardSigninPage();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height / 5,
        backgroundColor: Color(0xff3D525C),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Constants().fontStyleBold('ยินดีต้อนรับ',
                fontSize: 30, colorValue: Colors.white),
            SizedBox(
              height: 4,
            ),
            logoEatHub()
          ],
        ),
        leading: Container(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(48.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: Constants.paddingAppLRTB,
              child: Column(
                children: [
                  // Text(
                  //   'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}',
                  // ),
                  textFileEmail(),
                  textFilePassword(),
                  buttonForgotPassword(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [checkBox(), buttonForgotPassword()],
                  // ),
                  signInWithEmailMethod(context),
                  signInWithOTP(context),
                  buttonRegister(),
                  linerOr(),
                  // signInWithOTP(context, authBloc),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                // width: 2.0,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                authBloc.signInWithGoogle(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/GoogleLogo.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                            // SignInButton(
                            //   Buttons.Google,
                            //   mini: true,
                            //   onPressed: () {
                            //     authBloc.loginGoogle(context);
                            //   },
                            // ),
                            ),
                        // SizedBox(
                        //   width: 20,
                        // ),
                        (Platform.isIOS)
                            ? Container(
                                margin: EdgeInsets.only(left: 20),
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                    // width: 2.0,
                                  ),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    authBloc.signInWithApple(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/images/AppleLogo.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                // SignInButton(
                                //   Buttons.Apple,
                                //   mini: true,
                                //   onPressed: () {
                                //     authBloc.loginApple(context);
                                //   },
                                // ),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                  policy(),
                  Consumer<FragmentProvider>(
                    builder: (context, pvd, child) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Center(
                        child: Constants().fontStyleBold(
                            ApiPath().isGolive
                                ? 'เวอร์ชั่น ${pvd.versionText}'
                                : 'เวอร์ชั่น ${pvd.versionText}_${ApiPath.routeEndpoint}',
                            fontSize: 21,
                            colorValue: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Consumer signInWithEmailMethod(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, pvd, child) => ButtonAccept(
        onPressed: () => {
          if ((emailStrControl.text.isEmpty))
            {normalDialog(context, 'กรุณากรอกอีเมล หรือเบอร์โทรศัพท์')}
          else if (passwordStrControl.text.isEmpty)
            {normalDialog(context, 'กรุณากรอกรหัสผ่าน')}
          else if (emailStrControl.text.isEmpty &&
              passwordStrControl.text.isNotEmpty)
            {normalDialog(context, 'กรุณากรอกอีเมล หรือเบอร์โทรศัพท์')}
          else
            {
              print(
                  ' Email :: ${emailStrControl.toString()} pass :: ${passwordStrControl.toString()}'),
              pvd.sendLogInWithEmailToAPI(
                email: emailStrControl.text,
                password: passwordStrControl.text,
                context: context,
              )
            }
        },
        text: 'เข้าสู่ระบบ',
        fontColor: Colors.white,
        backgroundColor: Color(0xFFFEBC18),
        height: 50,
        fontStyleRegular: false,
      ),
    );
  }

  Widget signInWithOTP(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ButtonAccept(
        onPressed: () => {Navigator.pushNamed(context, '/signInWithOTP')},
        text: 'เข้าสู่ระบบด้วย OTP',
        fontColor: Colors.grey[800],
        backgroundColor: Colors.white,
        borderColor: Colors.grey,
        height: 50,
        fontStyleRegular: false,
      ),
    );
  }

  Widget logoEatHub() {
    return Image.asset(
      'assets/images/logopng.png',
      height: 130,
      width: 150,
      fit: BoxFit.cover,
    );
  }

  Widget buttonRegister() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => {Navigator.pushNamed(context, '/register')},
            child: Constants().fontStyleBold('ลงทะเบียน',
                fontSize: 21, colorValue: Color(0xFFFEBC18)),
          )
        ],
      ),
    );
  }

  Widget buttonForgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () => {Navigator.pushNamed(context, '/forgotPassword')},
          child: Constants().fontStyleBold('ลืมรหัสผ่าน',
              fontSize: 21, colorValue: Color(0xFFFEBC18)),
        ),
      ),
    );
  }

  Container textFileEmail() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants().fontStyleBold('เข้าสู่ระบบ', fontSize: 30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Constants()
                  .fontStyleBold('อีเมลหรือหมายเลขโทรศัพท์', fontSize: 24),
            ),
            TextFormField(
                style: Constants().textStyleRegular(fontSize: 22),
                controller: emailStrControl,
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.dark,
                autofocus: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Color(0xFFFEBC18)),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                )),
          ],
        ),
      ),
    );
  }

  Widget textFilePassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Constants().fontStyleBold('รหัสผ่าน', fontSize: 24),
          ),
          TextFormField(
            controller: passwordStrControl,
            style: Constants().textStyleRegular(fontSize: 22),
            autofocus: false,
            obscureText: _obscureText,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Color(0xFFFEBC18)),
              ),
              suffix: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: _obscureText
                    ? Constants().fontStyleBold('แสดง',
                        fontSize: 21, colorValue: Color(0xFFFEBC18))
                    : Constants().fontStyleBold('แสดง', fontSize: 21),
              ),
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 6),
            ),
          ),
        ],
      ),
    );
  }

  // Widget checkBox() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10),
  //     child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
  //       Transform.scale(
  //         scale: 1.0,
  //         child: Checkbox(
  //           value: _checkedValue,
  //           onChanged: (value) {
  //             toggleCheckbox(value!);
  //           },
  //           activeColor: Color(0xFFFEBC18),
  //           checkColor: Colors.white,
  //           tristate: false,
  //         ),
  //       ),
  //       Constants()
  //           .fontStyleBold('จำรหัสผ่าน', fontSize: 21, colorValue: Colors.grey)
  //     ]),
  //   );
  // }

  void toggleCheckbox(bool value) async {
    var preferences = await SharedPreferences.getInstance();
    if (_checkedValue == false) {
      setState(() {
        _checkedValue = true;
        valueCheck = preferences.setBool('valueCheck', true);
      });
    } else {
      setState(() {
        _checkedValue = false;
        valueCheck = preferences.setBool('valueCheck', false);
      });
    }
  }

  Widget linerOr() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.grey,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Constants()
                  .fontStyleBold('หรือ', fontSize: 21, colorValue: Colors.grey),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }

  Widget policy() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Consumer<GlobalURLProvider>(
        builder: (context, pvd, child) => Container(
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () =>
                              pvd.launchURL(context, pvd.termsPolicies),
                          child: Constants().fontStyleRegular(
                              'ข้อกำหนดและเงื่อนไข',
                              fontSize: 21,
                              colorValue: Colors.black),
                        )
                      ],
                    ),
                  )),
              Container(
                width: 1,
                height: 20,
                color: Colors.grey,
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => pvd.launchURL(context, pvd.urlPolicy),
                          child: Constants().fontStyleRegular(
                              'นโยบายความเป็นส่วนตัว',
                              fontSize: 21,
                              colorValue: Colors.black),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
