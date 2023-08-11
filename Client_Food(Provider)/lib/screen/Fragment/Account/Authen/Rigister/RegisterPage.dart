import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:/blocs/auth_bloc.dart';
import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:/screen/Fragment/Account/Authen/provider/RigisterProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:/utils/svg_img_code.dart';
import 'package:provider/provider.dart';

import '../../../FragmentProvider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final fname = TextEditingController();
  final lname = TextEditingController();
  final eMail = TextEditingController();
  final phoneCall = TextEditingController();
  final reFerralCode = TextEditingController();

  // final passwordController = TextEditingController();
  // final confirmPasswordController = TextEditingController();

  bool _checkedValue = false;
  bool showNewPassword = true, showConfirmPassword = true;
  late FocusNode newPasswordFocusNode, confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    newPasswordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();

    Provider.of<RegisterProvider>(context, listen: false).gender = 'NA';

    Provider.of<RegisterProvider>(context, listen: false)
        .passwordController
        .clear();

    Provider.of<RegisterProvider>(context, listen: false)
        .confirmPasswordController
        .clear();
  }

  @override
  void dispose() {
    super.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xff3D525C),
      //   toolbarHeight: MediaQuery.of(context).size.height / 8,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      //     onPressed: () => Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(
      //             builder: (BuildContext context) => SignInPage()),
      //         ModalRoute.withName('/')),
      //   ),
      //   //IconButt
      //   centerTitle: true,
      //   title: logoEatHub(),
      //   // flexibleSpace: Constants().flexibleSpaceInAppBar(),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(48.0),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              headerBar(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textFormField(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: privacyPolicy(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: checkBox(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: buttonRegister(context),
                  ),
                  // Spacer()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFormField() {
    return Consumer<RegisterProvider>(
      builder: (context, pvd, child) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              child: Constants().fontStyleBold('ลงทะเบียน', fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'ชื่อ',
                      style: Constants().textStyleBold(fontSize: 21),
                    ),
                    TextSpan(
                      text: ' *',
                      style: Constants()
                          .textStyleBold(fontSize: 21, colorValue: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: textFieldRow('ชื่อจริง', fname, TextInputType.text,
                  flag: 'fname'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'นามสกุล',
                      style: Constants().textStyleBold(fontSize: 21),
                    ),
                    TextSpan(
                      text: ' *',
                      style: Constants()
                          .textStyleBold(fontSize: 21, colorValue: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: textFieldRow('นามสกุล', lname, TextInputType.text,
                  flag: 'lname'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'เบอร์โทรศัพท์',
                      style: Constants().textStyleBold(fontSize: 21),
                    ),
                    TextSpan(
                      text: ' *',
                      style: Constants()
                          .textStyleBold(fontSize: 21, colorValue: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: textFieldRow(
                  'เบอร์โทรศัพท์', phoneCall, TextInputType.phone,
                  flag: 'phone'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Constants().fontStyleBold('อีเมล', fontSize: 21),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: textFieldRow('อีเมล', eMail, TextInputType.emailAddress),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Constants().fontStyleBold('เพศ', fontSize: 21),
            ),
            genderRadio(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: datePicker(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'รหัสผ่าน',
                      style: Constants().textStyleBold(fontSize: 21),
                    ),
                    TextSpan(
                      text: ' *',
                      style: Constants()
                          .textStyleBold(fontSize: 21, colorValue: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: textFieldPassword(
                newPasswordFocusNode,
                showNewPassword,
                pvd.passwordController,
                // getText: (value) {
                //   pvd.setPassWordValue(value);
                // },
                obscureTextBool: (value) {
                  showNewPassword = value;
                },
                text: 'รหัสผ่าน',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'ยืนยันรหัสผ่าน',
                      style: Constants().textStyleBold(fontSize: 21),
                    ),
                    TextSpan(
                      text: ' *',
                      style: Constants()
                          .textStyleBold(fontSize: 21, colorValue: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: textFieldPassword(
                confirmPasswordFocusNode,
                showConfirmPassword,
                pvd.confirmPasswordController,
                // getText: (value) {
                //   pvd.setConfirmPasswordValue(value);
                // },
                obscureTextBool: (value) {
                  showConfirmPassword = value;
                },
                text: 'ยืนยันรหัสผ่าน',
              ),
            ),

            // textFieldRow('รหัสอ้างอิง', pvd.reFerralCode, TextInputType.text),
          ],
        ),
      ),
    );
  }

  Widget datePicker() {
    return Consumer<RegisterProvider>(
      builder: (context, pvd, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants().fontStyleBold('วันเดือนปีเกิด', fontSize: 21),
            SizedBox(
              height: 10,
            ),
            DateTimePicker(
              type: DateTimePickerType.date,
              initialValue: '',
              dateMask: '  dd/MM/yyyy',
              decoration: InputDecoration(
                hintStyle:
                    Constants().textStyleRegular(colorValue: Color(0xFFC0C0C0)),
                //hintText: 'วัน/เดือน/ปีเกิด',
                suffixIcon: IconButton(
                  icon: SvgPicture.string(
                    SvgStringImg.icon_calendar,
                    allowDrawingOutsideViewBox: true,
                  ),
                  onPressed: () {},
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Color(0xFFFEBC18)),
                ),
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 8),
              ),
              style: Constants().textStyleRegular(fontSize: 21),
              firstDate: DateTime(1000),
              lastDate: DateTime(3000),
              fieldHintText: "DATE/MONTH/YEAR",
              onChanged: (value) {
                pvd.setBirthdayValue(value);
              },
              validator: (value) {
                print('validator::  $value');
                return null;
              },
              // onSaved: (val) => pvd.birthday,
            ),
          ],
        ),
      ),
    );
  }

  Widget textFieldRow(String text, TextEditingController controller,
      TextInputType textInputType,
      {String? flag}) {
    return Consumer<AuthBloc>(
      builder: (context, pvd, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: controller,
          keyboardType: textInputType,
          maxLength: flag == 'phone' ? 10 : 500,
          inputFormatters: flag == 'fname' || flag == 'lname'
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                ]
              : <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(RegExp(r'[+]')),
                ],
          obscureText:
              text == 'รหัสผ่าน' || text == 'ยืนยันรหัสผ่าน' ? true : false,
          decoration: InputDecoration(
            counterText: "",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(color: Color(0xFFFEBC18)),
            ),

            hintText: text,
            hintStyle:
                Constants().textStyleRegular(colorValue: Color(0xFFC0C0C0)),
            contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(0F.0)),
          ),
        ),
      ),
    );
  }

  Widget genderRadio() {
    return Consumer<RegisterProvider>(
      builder: (context, pvd, child) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Row(
                children: [
                  Radio(
                    splashRadius: 0,
                    activeColor: Color(0xFFFEBC18),
                    value: 'M',
                    groupValue: pvd.genderValue,
                    onChanged: (value) async =>
                        pvd.setGenderValue(value.toString()),
                  ),
                  Constants().fontStyleBold(
                    'ชาย',
                    fontSize: 21,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Row(
              children: [
                Radio(
                  activeColor: Color(0xFFFEBC18),
                  value: 'F',
                  groupValue: pvd.genderValue,
                  onChanged: (value) async =>
                      pvd.setGenderValue(value.toString()),
                ),
                Constants().fontStyleBold(
                  'หญิง',
                  fontSize: 21,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Row(
              children: [
                Radio(
                  activeColor: Color(0xFFFEBC18),
                  value: '',
                  groupValue: pvd.genderValue,
                  onChanged: (value) async =>
                      pvd.setGenderValue(value.toString()),
                ),
                Constants().fontStyleBold(
                  'ไม่ระบุ',
                  fontSize: 21,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget privacyPolicy() {
    return Consumer<GlobalURLProvider>(
      builder: (context, pvd, child) => Container(
        child: Row(
          children: [
            InkWell(
              onTap: () => pvd.launchURL(context, pvd.termsPolicies),
              child: Constants().fontStyleBold('ข้อกำหนดและเงื่อนไข',
                  fontSize: 21, colorValue: Color(0xFFFEBC18)),
            ),
            Constants().fontStyleBold(' และ ',
                fontSize: 21, colorValue: Color(0xFF7A7A7A)),
            InkWell(
              onTap: () => pvd.launchURL(context, pvd.urlPolicy),
              child: Constants().fontStyleBold('นโยบายความเป็นส่วนตัว',
                  fontSize: 21, colorValue: Color(0xFFFEBC18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonRegister(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Consumer<RegisterProvider>(
        builder: (context, pvd, child) => ButtonAccept(
          onPressed: () {
            print(pvd.passwordController.text);
            print(pvd.confirmPasswordController.text);
            print(validateStructure(
                pvd.confirmPasswordController.text.toString()));

            if (fname.text.isEmpty) {
              normalDialog(context, 'โปรดระบุชื่อ');
            } else if (lname.text.isEmpty) {
              normalDialog(context, 'โปรดระบุนามสกุล');
            } else if (phoneCall.text.isEmpty) {
              normalDialog(context, 'โปรดระบุเบอร์ติดต่อ');
            } else if (pvd.passwordController.text.isEmpty) {
              normalDialog(context, 'โปรดระบุรหัสผ่าน');
            } else if (validateStructure(
                    pvd.confirmPasswordController.text.toString()) ==
                false) {
              normalDialog(context,
                  'รหัสผ่านต้องมีจำนวน 8 ตัวขึ้นไปโดยประกอบด้วยตัวเลขและตัวอักษรภาษาอังกฤษ ทั้งพิมพ์เล็ก และพิมพ์ใหญ่');
            } else if (phoneCall.text.isEmpty) {
              normalDialog(context, 'โปรดระบุเบอร์ติดต่อ');
            } else if (pvd.confirmPasswordController.text.isEmpty) {
              normalDialog(context, 'โปรดยืนยันรหัสผ่าน');
            } else if (pvd.passwordController.text.toString() !=
                pvd.confirmPasswordController.text.toString()) {
              normalDialog(context, 'รหัสผ่านไม่ตรงกัน').then(
                (value) {
                  pvd.passwordController.clear();
                  pvd.confirmPasswordController.clear();
                },
              );
            } else if (_checkedValue == true) {
              pvd.sendCreateUserAPI(
                context,
                email: eMail.text.toString(),
                password: pvd.passwordController.text.toString(),
                firstname: fname.text.toString(),
                lastname: lname.text.toString(),
                phone: phoneCall.text.toString(),
                gender: pvd.genderValue,
                birthday: pvd.birthdayValue,
                referralCode: reFerralCode.text.toString(),
              );

              // (
              //   context: context,
              //   email: pvd.eMail.text.isEmpty ? data : pvd.eMail.text,
              //   password: pvd.passWord.toString(),
              //   firstname: pvd.fname.text,
              //   lastname: pvd.lname.text,
              //   gender: pvd.gender == '' ? data : pvd.gender.toString(),
              //   phone: pvd.phoneCall.text,
              //   referralCode: pvd.reFerralCode.text,
              //   birthday: pvd.birthday.toString(),
              // );

              // setState(
              //   () {
              //     pvd.passWord = "";
              //     pvd.confirmPassword = "";
              //     pvd.gender = "";
              //     pvd.reFerralCode.clear();
              //     // pvd.eMail.clear();
              //     pvd.fname.clear();
              //     pvd.lname.clear();
              //     // pvd.birthday= "";
              //   },
              // );
            } else {
              normalDialog(
                  context, 'กรุณากดยอมรับเงื่อนไข\nและนโยบายความเป็นส่วนตัว');
            }
          },
          text: 'ลงทะเบียน',
          fontColor: Colors.white,
          backgroundColor: Color(0xFFFEBC18),
          width: MediaQuery.of(context).size.width,
          height: 50,
          fontStyleRegular: false,
        ),
      ),
    );
  }

  Widget checkBox(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Transform.scale(
        scale: 1.0,
        child: Checkbox(
          value: _checkedValue,
          onChanged: (value) {
            toggleCheckbox(value!);
          },
          activeColor: Color(0xFFFEBC18),
          checkColor: Colors.white,
          tristate: false,
        ),
      ),
      Constants().fontStyleBold('ยอมรับข้อกำหนด',
          fontSize: 21, colorValue: Color(0xFF7A7A7A))
    ]);
  }

  void toggleCheckbox(bool value) {
    if (_checkedValue == false) {
      setState(() {
        _checkedValue = true;
      });
    } else {
      setState(() {
        _checkedValue = false;
      });
    }
  }

  Container textFieldPassword(
      FocusNode focusNode, bool obscureText, TextEditingController controller,
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
        child: Column(
          children: [
            TextFormField(
                // onChanged: (v) {
                //   setState(() {
                //     getText!(v);
                //   });
                // },
                controller: controller,
                focusNode: focusNode,
                onTap: onTap,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey[350]),
                  //hintText: text,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
                  suffixIcon: IconButton(
                      icon: obscureText == false
                          ? SvgPicture.string(
                              SvgStringImg.icon_password_visibility_off,
                              allowDrawingOutsideViewBox: true,
                            )

                          // Icon(
                          //     Icons.visibility_off,
                          //     color: Color(0xFFFEBC18),
                          //   )
                          : SvgPicture.string(
                              SvgStringImg.icon_password_visibility,
                              allowDrawingOutsideViewBox: true,
                            ),

                      //  Icon(Icons.visibility),
                      onPressed: () => setState(() {
                            print(obscureText);
                            obscureText = !obscureText;
                            obscureTextBool!(obscureText);
                            print(obscureText);
                          })),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: Color(0xFFFEBC18)),
                  ),
                ),
                validator: (String? valueNewPassword) {
                  if (validateStructure(valueNewPassword!) == false) {
                    return 'รหัสผ่านต้องมีจำนวน 8 ตัวขึ้นไป โดยประกอบด้วย ตัวเลขและตัวอักษรภาษาอังกฤษ';
                  }
                  return null;
                }),
          ],
        ),
      ),
    );
  }

  bool validateStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    //String pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateEmail(String value) {
    String patternM =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(patternM);
    return (!regex.hasMatch(value)) ? false : true;
  }

  Widget headerBar() {
    return Consumer<FragmentProvider>(
      builder: (context, pvd, child) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
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
                    onTap: () => {
                      pvd.onClickSingout(context),
                      Navigator.popUntil(
                          context, ModalRoute.withName('/fragment'))
                    },
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
      ),
    );
  }

  Widget logoEatHub() {
    return Image.asset(
      'assets/images/logopng.png',
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    );
  }
}
