import 'package:flutter/material.dart';
import 'package:/blocs/forgetpassword_provider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:provider/provider.dart';

class ChangePasswordOTPForgotPage extends StatefulWidget {
  const ChangePasswordOTPForgotPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordOTPForgotPageState createState() =>
      _ChangePasswordOTPForgotPageState();
}

class _ChangePasswordOTPForgotPageState
    extends State<ChangePasswordOTPForgotPage> {
  String textCurrentPassword = '',
      textNewPassword = '',
      textConfirmPassword = '';
  bool showCurrentPassword = true,
      showNewPassword = true,
      showConfirmPassword = true;
  late FocusNode currentPasswordFocusNode,
      newPasswordFocusNode,
      confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    currentPasswordFocusNode = FocusNode();
    newPasswordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    currentPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              headerBar(),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Constants().fontStyleBold('เปลี่ยนรหัสผ่าน', fontSize: 30),
                    Constants().fontStyleBold('รหัสผ่าน', fontSize: 24),
                    textFieldPassword(newPasswordFocusNode, showNewPassword,
                        text: 'รหัสผ่านใหม่', obscureTextBool: (v) {
                      setState(() {
                        showNewPassword = v;
                      });
                    }, getText: (v) {
                      setState(() {
                        textNewPassword = v;
                      });
                    }),
                    Constants().fontStyleBold('ยืนยันรหัสผ่าน', fontSize: 24),
                    textFieldPassword(
                        confirmPasswordFocusNode, showConfirmPassword,
                        text: 'ยืนยันรหัสผ่านใหม่', obscureTextBool: (v) {
                      setState(() {
                        showConfirmPassword = v;
                      });
                    }, getText: (v) {
                      setState(() {
                        textConfirmPassword = v;
                      });
                    }),
                    button(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container textFieldPassword(FocusNode focusNode, bool obscureText,
      {String? text,
      ValueChanged<bool>? obscureTextBool,
      ValueChanged<String>? getText}) {
    text ??= '';
    onTap() {
      setState(() {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(focusNode);
      });
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: TextFormField(
            onChanged: (v) {
              setState(() {
                getText!(v);
              });
            },
            focusNode: focusNode,
            onTap: onTap,
            obscureText: obscureText,
            decoration: InputDecoration(
              // hintStyle: TextStyle(fontSize: 16, color: Color(0xFF7A7A7A)),
              // hintText: text,
              suffixIcon: IconButton(
                  icon: obscureText == false
                      ? Icon(Icons.remove_red_eye_outlined,
                          color: Color(0xFFFEBC18))
                      : Icon(Icons.remove_red_eye),
                  onPressed: () => setState(() {
                        print(obscureText);
                        obscureText = !obscureText;
                        obscureTextBool!(obscureText);
                        print(obscureText);
                      })),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Color(0xFFFEBC18)),
              ),
            ),
            validator: (String? valueNewPassword) {
              if (validateStructure(valueNewPassword!) == false) {
                return 'รหัสผ่านต้องมีจำนวน 8 ตัวขึ้นไป โดยประกอบด้วย ตัวเลข และตัวอักษรภาษาอังกฤษ';
              }
              return null;
            }),
      ),
    );
  }

  Container button() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Consumer<ForgotPasswordProvider>(
        builder: (context, pvd, child) => ButtonAccept(
          onPressed: () {
            if ((textNewPassword.toString().isEmpty) ||
                textConfirmPassword.toString().isEmpty) {
              normalDialog(context, 'กรุณากรอกข้อมูล');
            } else if (validateStructure(textNewPassword.toString()) == false) {
              normalDialog(context,
                  'รหัสผ่านต้องมีจำนวน 8 ตัวขึ้นไป\nโดยประกอบด้วยตัวเลข (0-9)\nและตัวอักษรภาษาอังกฤษ (a-z)');
            } else if (textNewPassword.toString() ==
                textConfirmPassword.toString()) {
              pvd.changePasswordOTPForget(
                context,
                textNewPassword.toString(),
                textConfirmPassword.toString(),
              );
            } else {
              normalDialog(context, 'รหัสผ่านไม่ตรงกัน !!');
            }

            print(
                ' $textCurrentPassword ,$textNewPassword ,$textConfirmPassword ');
          },
          text: 'เปลี่ยนรหัสผ่าน',
          fontSize: 22,
          height: 55,
          fontColor: Colors.white,
          backgroundColor: Colors.amber,
          fontStyleRegular: false,
        ),
      ),
    );
  }

  String? validate;

  bool validateStructure(String value) {
    // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

//   r'^
//   (?=.*[A-Z])       // should contain at least one upper case
//   (?=.*[a-z])       // should contain at least one lower case
//   (?=.*?[0-9])      // should contain at least one digit
//   (?=.*?[!@#\$&*~]) // should contain at least one Special character
//   .{8,}             // Must be at least 8 characters in length
// $

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
