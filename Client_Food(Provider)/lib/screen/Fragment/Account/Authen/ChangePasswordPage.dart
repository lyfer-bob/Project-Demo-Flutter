import 'package:flutter/material.dart';
import 'package:/blocs/auth_bloc.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
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
      appBar: AppBar(
        leading: Constants().leadingBackIconAppBar(context),
        centerTitle: false,
        title: Constants().fontStyleBold('เปลี่ยนรหัสผ่าน', fontSize: 21),
        flexibleSpace: Constants().flexibleSpaceInAppBar(),
      ),
      body: Container(
        child: Padding(
          padding: Constants.paddingAppLRTB,
          child: Column(
            children: [
              textFieldPassword(currentPasswordFocusNode, showCurrentPassword,
                  text: 'รหัสผ่านปัจจุบัน', obscureTextBool: (v) {
                setState(() {
                  showCurrentPassword = v;
                });
              }, getText: (v) {
                setState(() {
                  textCurrentPassword = v;
                });
              }),
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
              textFieldPassword(confirmPasswordFocusNode, showConfirmPassword,
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
        padding: const EdgeInsets.symmetric(vertical: 10),
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
              hintStyle: TextStyle(fontSize: 16, color: Color(0xFF7A7A7A)),
              hintText: text,
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
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFEBC18))),
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
      child: Consumer<AuthBloc>(
        builder: (context, pvd, child) => ButtonAccept(
          onPressed: () {
            if ((textCurrentPassword.toString().isEmpty) ||
                (textNewPassword.toString().isEmpty) ||
                textConfirmPassword.toString().isEmpty) {
              normalDialog(context, 'กรุณากรอกข้อมูล');
            } else if (validateStructure(textNewPassword.toString()) == false) {
              normalDialog(context,
                  'รหัสผ่านต้องมีจำนวน 8 ตัวขึ้นไป\nโดยประกอบด้วยตัวเลข (0-9)\nและตัวอักษรภาษาอังกฤษ (a-z)');
            } else if (textNewPassword.toString() ==
                textConfirmPassword.toString()) {
              pvd.sendChangePassword(
                oldPassword: textCurrentPassword.toString(),
                currentPassword: textNewPassword.toString(),
                password: textConfirmPassword.toString(),
                context: context,
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
}
