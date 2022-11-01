import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:/screen/Fragment/FragmentProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'provider/ProfileCustomerProvider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPAgeState createState() => _AccountPAgeState();
}

class _AccountPAgeState extends State<AccountPage> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  void initState() {
    super.initState();

    Provider.of<ProfileCustomerProvider>(context, listen: false)
        .initData(context);

    Provider.of<ProfileCustomerProvider>(context, listen: false)
        .name
        .addListener(
      () {
        Provider.of<ProfileCustomerProvider>(context, listen: false)
            .setUserNameValue();
      },
    );

    Provider.of<ProfileCustomerProvider>(context, listen: false)
        .surname
        .addListener(
      () {
        Provider.of<ProfileCustomerProvider>(context, listen: false)
            .setLastNameValue();
      },
    );

    Provider.of<ProfileCustomerProvider>(context, listen: false)
        .phone
        .addListener(
      () {
        print(
            Provider.of<ProfileCustomerProvider>(context, listen: false).phone);

        Provider.of<ProfileCustomerProvider>(context, listen: false)
            .setPhoneValue();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfileCustomerProvider, FragmentProvider>(
      builder: (context, profileCustomerProviderValue, pvd, child) =>
          WillPopScope(
        onWillPop: () {
          // print(
          //     'nameUser:: ${profileCustomerProviderValue.nameUser.toString().isEmpty}');
          // print(
          //     'lastNameUser:: ${profileCustomerProviderValue.lastNameUser.toString().isEmpty}');
          // print(
          //     'phoneNoUser:: ${profileCustomerProviderValue.phoneNoUser.toString().isEmpty}');

          if (profileCustomerProviderValue.socialLogInBool) {
            Navigator.popUntil(context, ModalRoute.withName('/fragment'));
          } else {
            if (profileCustomerProviderValue.nameUser.toString().isEmpty ||
                profileCustomerProviderValue.lastNameUser.toString().isEmpty ||
                profileCustomerProviderValue.phoneNoUser.toString().isEmpty) {
              normalDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
            } else {
              Navigator.popUntil(context, ModalRoute.withName('/fragment'));
            }
          }

          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                if (profileCustomerProviderValue.socialLogInBool) {
                  Navigator.popUntil(context, ModalRoute.withName('/fragment'));
                } else {
                  if (profileCustomerProviderValue.nameUser
                          .toString()
                          .isEmpty ||
                      profileCustomerProviderValue.lastNameUser
                          .toString()
                          .isEmpty ||
                      profileCustomerProviderValue.phoneNoUser
                          .toString()
                          .isEmpty) {
                    normalDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
                  } else {
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, '/fragment', (route) => false);

                    Navigator.popUntil(
                        context, ModalRoute.withName('/fragment'));
                  }
                }
              },
            ),
            centerTitle: false,
            title: Constants().fontStyleBold('ข้อมูลส่วนตัว', fontSize: 21),
            flexibleSpace: Constants().flexibleSpaceInAppBar(),
          ),
          body: SingleChildScrollView(
            child: profileCustomerProviderValue.model!.result!.success == '0'
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Constants().progressAPI(),
                    ),
                  )
                : Container(
                    child: Padding(
                      padding: Constants.paddingAppLRTB,
                      child: Column(
                        children: [
                          textFormFieldAccount(
                              'ชื่อจริง', profileCustomerProviderValue.name),
                          textFormFieldAccount(
                              'นามสกุล', profileCustomerProviderValue.surname),
                          textFormFieldAccount(
                              'อีเมล', profileCustomerProviderValue.eMail),

                          textFormFieldAccount('เบอร์โทรศัพท์',
                              profileCustomerProviderValue.phone,
                              textInputType: TextInputType.phone,
                              isReadOnly:
                                  profileCustomerProviderValue.havePhoneNoBool),
                          genderRadio(),
                          //radioButton(),
                          birthDayDatePicker(),
                          buttonSave()
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget textFormFieldAccount(
    String textTitle,
    TextEditingController? controller, {
    bool isReadOnly = false,
    TextInputType textInputType = TextInputType.emailAddress,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constants().fontStyleBold(textTitle,
              fontSize: 18, colorValue: Color(0xFFC0C0C0)),
          TextFormField(
            controller: controller,
            // readOnly: isReadOnly,
            maxLength: textTitle == 'เบอร์โทรศัพท์' ? 10 : null,
            style: Constants()
                .textStyleBold(colorValue: Color(0xFF3D525C), fontSize: 21),
            keyboardType: textInputType,
            autofocus: false,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFEBC18)),
              ),
              contentPadding: EdgeInsets.fromLTRB(10.0, 0, 20.0, 0),
            ),
          ),
        ],
      ),
    );
  }

  Widget genderRadio() {
    return Consumer<ProfileCustomerProvider>(
      builder: (context, pvd, child) => Column(
        children: [
          Constants().fontStyleBold('เพศ',
              fontSize: 18, colorValue: Color(0xFFC0C0C0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Row(
                  children: [
                    Radio(
                      splashRadius: 0,
                      activeColor: Color(0xFFFEBC18),
                      value: 'M',
                      groupValue: pvd.genderUser,
                      onChanged: (value) async =>
                          pvd.setGenderUser(value.toString()),
                    ),
                    Constants().fontStyleBold(
                      'ชาย',
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
                      value: 'F',
                      groupValue: pvd.genderUser,
                      onChanged: (value) async =>
                          pvd.setGenderUser(value.toString()),
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
                      groupValue: pvd.genderUser,
                      onChanged: (value) async =>
                          pvd.setGenderUser(value.toString()),
                    ),
                    Constants().fontStyleBold(
                      'ไม่ระบุเพศ',
                      fontSize: 21,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            color: Colors.grey[400],
            height: 1.5,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }

  // Widget radioButton() {
  //   return Consumer<ProfileCustomerProvider>(
  //     builder: (context, pvd, child) => Container(
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 10),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: <Widget>[
  //             Constants().fontStyleBold('เพศ',
  //                 fontSize: 18, colorValue: Color(0xFFC0C0C0)),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 Row(
  //                   children: [
  //                     Radio(
  //                       activeColor: Color(0xFFFEBC18),
  //                       value: 'M',
  //                       groupValue: pvd.groupValue,
  //                       onChanged: (newValue) async => setState(
  //                           () => pvd.groupValue = newValue as String?),
  //                     ),
  //                     Constants().fontStyleBold(
  //                       'ชาย',
  //                       fontSize: 21,
  //                       colorValue: Color(0xFFC0C0C0),
  //                     ),
  //                   ],
  //                 ),
  //                 Row(
  //                   children: [
  //                     Radio(
  //                       activeColor: Color(0xFFFEBC18),
  //                       value: 'F',
  //                       groupValue: pvd.groupValue,
  //                       onChanged: (newValue) async => setState(
  //                           () => pvd.groupValue = newValue as String?),
  //                     ),
  //                     Constants().fontStyleBold(
  //                       'หญิง',
  //                       fontSize: 21,
  //                       colorValue: Color(0xFFC0C0C0),
  //                     ),
  //                   ],
  //                 ),
  //                 Row(
  //                   children: [
  //                     Radio(
  //                       activeColor: Color(0xFFFEBC18),
  //                       value: '',
  //                       groupValue:
  //                           pvd.groupValue != 'F' && pvd.groupValue != 'M'
  //                               ? ''
  //                               : pvd.groupValue.toString(),
  //                       onChanged: (newValue) async => setState(
  //                           () => pvd.groupValue = newValue as String?),
  //                     ),
  //                     Constants().fontStyleBold(
  //                       'ไม่ระบุเพศ',
  //                       fontSize: 21,
  //                       colorValue: Color(0xFFC0C0C0),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             Container(
  //               color: Colors.grey[400],
  //               height: 1.5,
  //               width: MediaQuery.of(context).size.width,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget birthDayDatePicker() {
    return Consumer<ProfileCustomerProvider>(
      builder: (context, pvd, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constants().fontStyleBold('วันเดือนปีเกิด',
              fontSize: 18, colorValue: Color(0xFFC0C0C0)),
          DateTimePicker(
            type: DateTimePickerType.date,
            dateMask: '  dd MMM, yyyy',
            decoration: InputDecoration(
              hintStyle: Constants()
                  .textStyleBold(colorValue: Colors.black, fontSize: 20),
              hintText: '   ${pvd.birthday.text.toString()}',
              suffixIcon:
                  Icon(Icons.calendar_today_rounded, color: Color(0xFFFEBC18)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFEBC18),
                ),
              ),
            ),
            style: Constants().textStyleBold(fontSize: 21),
            firstDate: DateTime(1000),
            lastDate: DateTime(3000),
            fieldHintText: "DATE/MONTH/YEAR",
            onChanged: (val) {
              pvd.birthday.text = val;
              print('birthday :: $val');
            },
            validator: (val) {
              pvd.birthday.text = val!;
              print('birthday :: $val');
              return null;
            },
            onSaved: (val) => print(val),
          ),
        ],
      ),
    );
  }

  Widget buttonSave() {
    return Consumer<ProfileCustomerProvider>(
      builder: (context, pvd, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: ButtonAccept(
          onPressed: () async {
            bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(pvd.eMail.text.toString());

            if (pvd.nameUser.toString().isEmpty ||
                pvd.lastNameUser.toString().isEmpty ||
                pvd.phoneNoUser.toString().isEmpty) {
              normalDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
            } else if (!emailValid &&
                pvd.eMailUser.toString().trim().length > 0) {
              normalDialog(context, 'กรุณากรอกอีเมลให้ถูกต้อง');
            } else {
              pvd.requestOTPRegistModel = null;
              pvd.setLabelErrorOTP('');

              Constants().printColorCyan('${pvd.phoneNoUser}');
              Constants().printColorCyan('${pvd.model!.result!.customerPhone}');

              if (pvd.phoneNoUser == pvd.model!.result!.customerPhone) {
                pvd.sendProfileUpdate(
                  context,
                  email: pvd.eMail.text.toString(),
                  firstname: pvd.nameUser.toString(),
                  lastname: pvd.lastNameUser.toString(),
                  phone: pvd.phoneNoUser.toString(),
                  gender: pvd.genderUser.toString(),
                  birthday: pvd.birthday.text.toString(),
                );
              } else {
                Constants().dialogProgress(context);
                await pvd.requestRegisterWithOTP(context, pvd.phoneNoUser);

                if (pvd.requestOTPRegistModel!.result!.success.toString() ==
                    '1') {
                  Constants().dialogProgress(context, pop: true);
                  dialogOTP(context, dialogYesNo: true, onPressed: () async {
                    if (_pinPutController.text.length == 6) {
                      await pvd.validateRegisterWithOTP(context,
                          pinCode: '${_pinPutController.text}');
                      if (pvd.checkSuccessOTP) {
                        pvd.sendProfileUpdate(
                          context,
                          email: pvd.eMail.text.toString(),
                          firstname: pvd.nameUser.toString(),
                          lastname: pvd.lastNameUser.toString(),
                          phone: pvd.phoneNoUser.toString(),
                          gender: pvd.genderUser.toString(),
                          birthday: pvd.birthday.text.toString(),
                        );
                        Navigator.pop(context);
                      }
                    } else {
                      pvd.setLabelErrorOTP('กรุณากรอกให้ถูกต้อง');
                    }
                  });
                }
              }
            }
          },
          text: 'บันทึก',
          fontColor: Colors.white,
          backgroundColor: Color(0xFFFEBC18),
          width: MediaQuery.of(context).size.width,
          height: 50,
        ),
      ),
    );
  }

  Future<Null> dialogOTP(BuildContext context,
      {onPressed,
      onPressedSec,
      String? text,
      String? textSec,
      bool? dialogYesNo}) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => SimpleDialog(
        insetPadding: EdgeInsets.all(10),
        title: Consumer<ProfileCustomerProvider>(
          builder: (context, pvd, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                child: Constants().showLogo(),
              ),
              Constants().fontStyleBold('กรุณากรอกหมายเลข OTP', fontSize: 20),
              Constants().fontStyleBold(
                  'ที่ส่งไปยังหมายเลข : ${pvd.phoneNoUser ?? ''}',
                  fontSize: 20),
              Constants().fontStyleBold(
                  '[Ref : ${pvd.requestOTPRegistModel?.result?.pinId ?? ''}]',
                  fontSize: 20),
              FittedBox(
                fit: BoxFit.cover,
                child: Container(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    child: Pinput(
                      defaultPinTheme: PinTheme(
                        height: 55,
                        width: 55,
                        margin: EdgeInsets.only(right: 5),
                      ),
                      focusedPinTheme: PinTheme(
                          textStyle:
                              TextStyle(fontSize: 25, fontFamily: 'THSarabun'),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          )),
                      keyboardType: TextInputType.phone,
                      submittedPinTheme: PinTheme(
                        decoration: _pinPutDecoration,
                        textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'THSarabun'),
                      ),
                      focusNode: _pinPutFocusNode,
                      length: 6,
                      controller: _pinPutController,
                      // mainAxisSize: MainAxisSize.min,
                      followingPinTheme: PinTheme(
                          decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      )),
                    )),
              ),
              Constants().fontStyleBold('${pvd.labelError}',
                  colorValue: Colors.red, fontSize: 20),
            ],
          ),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: dialogYesNo ?? false,
                child: TextButton(
                    onPressed: onPressedSec ?? () => Navigator.pop(context),
                    child: Constants()
                        .fontStyleRegular(textSec ?? 'ยกเลิก', fontSize: 20)),
              ),
              TextButton(
                  onPressed: onPressed ?? () => Navigator.pop(context),
                  child: Constants()
                      .fontStyleRegular(text ?? 'ตกลง', fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }

  Widget textFieldDisable(BuildContext context, String textTitle,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constants().fontStyleBold(textTitle,
              fontSize: 18, colorValue: Color(0xFFC0C0C0)),
          TextFormField(
            controller: controller,
            readOnly: true,
            enabled: false,
            style: Constants()
                .textStyleBold(colorValue: Color(0xFF3D525C), fontSize: 21),
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFEBC18)),
              ),
              contentPadding: EdgeInsets.fromLTRB(10.0, 0, 20.0, 0),
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration get _pinPutDecoration {
  return BoxDecoration(
    border: Border.all(color: Color(0xFFFEBC18)),
    borderRadius: BorderRadius.circular(3.0),
  );
}
