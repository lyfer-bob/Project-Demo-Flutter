import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:project_test/blocs/Login_provider.dart';
import 'package:project_test/blocs/globalURL_provider.dart';
import 'package:project_test/blocs/nation/register_otp_provider.dart';
import 'package:project_test/services/api_path.dart';
import 'package:project_test/utils/constant_value.dart';
import 'package:project_test/widgets/buttonAccept.dart';
import 'package:provider/provider.dart';

class RequestOTPRegister extends StatefulWidget {
  const RequestOTPRegister({Key? key}) : super(key: key);

  @override
  State<RequestOTPRegister> createState() => _RequestOTPRegisterState();
}

class _RequestOTPRegisterState extends State<RequestOTPRegister> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    isLoading = false;

    Provider.of<RegisterOTPProvider>(context, listen: false)
        .phoneController
        .clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_register.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 50, bottom: 30),
                  child: Constants().showLogoRegis(),
                ),
                containerRequest(context),
                containerDetail(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container containerRequest(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 25),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 10),
        child: Consumer2<GlobalURLProvider, RegisterOTPProvider>(
          builder: (context, globalURLProviderValue, regisOTPPvd, child) =>
              Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.12),
                      child: InkWell(
                        onTap: () {
                          regisOTPPvd.phoneController.clear();

                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back, size: 20),
                      ),
                    ),
                    Text(
                      'ระบบลงทะเบียนสำหรับคนขับ',
                      style: Constants().fontSarabunNormal(16),
                    ),
                  ],
                ),
              ),
              Text(
                'ลงทะเบียน',
                style: Constants().fontSarabunNormal(18),
              ),
              SizedBox(
                width: 100,
                child: Divider(color: Constants().defaultColor, thickness: 2),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'เบอร์โทรศัพท์',
                              style: TextStyle(
                                  color: Color(0xFF3D525C),
                                  fontFamily: 'Sarabun',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal)),
                          TextSpan(
                              text: '*',
                              style: TextStyle(
                                  color: Color(0xffee0000),
                                  fontFamily: 'Sarabun',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              inputNumber(),
              checkBox(),
              btnSubmit(context),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  ApiPath().isGolive
                      ? 'เวอร์ชั่น ${globalURLProviderValue.localVersion}'
                      : 'เวอร์ชั่น ${globalURLProviderValue.localVersion}${ApiPath().subfixStringPATH}',
                  style: Constants()
                      .fontSarabunNormal(14, colorValue: Color(0xffc0c0c0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding checkBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 20, top: 10),
      child: Consumer2<LoginProvider, RegisterOTPProvider>(
        builder: (context, loginPvd, regisOTPPvd, child) => Row(
          children: [
            Checkbox(
                activeColor: Constants().textColor,
                value: regisOTPPvd.checkBoxValue,
                onChanged: (value) {
                  regisOTPPvd.setCheckBox(value!);
                  debugPrint(regisOTPPvd.checkBoxValue.toString());
                }),
            Container(
              width: MediaQuery.of(context).size.width - 110,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'ฉันได้อ่านและยอมรับ',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        color: Color(0xff7a7a7a),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Constants().launchURL(
                            context, '${loginPvd.termsModel!.result!.value}'),
                      text: ' เงื่อนไขการใช้บริการ ',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        color: Color(0xff00a2ef),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    TextSpan(
                      text: 'และ',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        color: Color(0xff7a7a7a),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Constants().launchURL(
                            context, '${loginPvd.policyModel!.result!.value}'),
                      text: ' นโยบายความเป็นส่วนตัว ',
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        color: Color(0xff00a2ef),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding inputNumber() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Consumer2<LoginProvider, RegisterOTPProvider>(
        builder: (context, loginPvd, regisOTPPvd, child) => Container(
          child: TextField(
            controller: regisOTPPvd.phoneController,
            cursorColor: Constants().defaultColor,
            style: TextStyle(
              fontFamily: 'Sarabun',
              fontSize: 20,
              height: 0.8,
            ),
            decoration: InputDecoration(
                counterText: '',
                focusedBorder: borderStyle(),
                border: borderStyle()),
            keyboardType: TextInputType.phone,
            onChanged: (newValue) {
              regisOTPPvd.phoneController.text = newValue;
              print(newValue);
              if (newValue.length == 12) {
                regisOTPPvd.setlengthNumberReq(true);
              } else {
                regisOTPPvd.setlengthNumberReq(false);
              }
              regisOTPPvd.phoneController.selection =
                  TextSelection.fromPosition(TextPosition(
                      offset: regisOTPPvd.phoneController.text.length));
            },
            maxLength: 12,
            autocorrect: false,
            inputFormatters: [
              MaskedInputFormatter('###-###-####'),
            ],
          ),
        ),
      ),
    );
  }

  Container btnSubmit(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Consumer<RegisterOTPProvider>(
        builder: (context, regisOTPPvd, child) => ButtonAccept(
          onPressed: regisOTPPvd.checklengthNumberReq &&
                  regisOTPPvd.checkBoxValue
              ? () {
                  if (regisOTPPvd.checklengthNumberReq &&
                      regisOTPPvd.checkBoxValue) {
                    final original = '${regisOTPPvd.phoneController.text}';
                    final find = '-';
                    final replaceWith = '';
                    final newString = original.replaceAll(find, replaceWith);
                    String result = '$newString';
                    print('$result');

                    Constants()
                        .printColorCyan('|| CHECK MOBILE No. COMPLETED ||');

                    if (!isLoading) {
                      isLoading = true;

                      regisOTPPvd.requestRegisterOTP().whenComplete(
                        () {
                          isLoading = false;
                          Navigator.pushNamed(context, '/validateRegister');
                        },
                      );
                    }

                    // .then(
                    //   (value) async {
                    //     Constants().printColorCyan(
                    //         '|| AFTER CALL requestRegisterOTP COMPLETED ||');

                    //     Constants().printColorCyan('|| value :: $value ||');
                    //   },
                    // );

                    //Navigator.pushNamed(context, '/validateRegister');

                    // pvd.setLabel('', 'otpLogin');
                    // pvd.apiRequestOTPLogin(result).then((value) {
                    //   if (pvd.requestOTPLogin!.result!.success == 1) {
                    //     Navigator.pushNamed(
                    //       context,
                    //       '/validateOTP',
                    //       arguments: result,
                    //     );
                    //   } else {
                    //     setState(() {});
                    //   }
                    // });
                  } else {
                    // print('กรุณากรอก เบอร์โทรศัพท์');
                    // if (phoneController.text.length > 0 &&
                    //     phoneController.text.length < 12) {
                    //   pvd.setLabel('เบอร์โทรศัพท์ ไม่ถูกต้อง', 'otpLogin');
                    //   setState(() {});
                    // } else {
                    //   pvd.setLabel('กรุณากรอก เบอร์โทรศัพท์', 'otpLogin');
                    //   setState(() {});
                    // }
                  }
                }
              : null,
          text: 'ขอรหัส OTP',
          height: 50,
          fontColor: Colors.white,
          fontSize: 16,
          backgroundColor:
              regisOTPPvd.checkBoxValue && regisOTPPvd.checklengthNumberReq
                  ? Constants().defaultColor
                  : Colors.grey,
        ),
      ),
    );
  }

  Container containerDetail(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 25),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 30, bottom: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                "เอกสารที่ใช้ในการสมัคร",
                style: Constants().fontSarabunNormal(
                  18,
                  colorValue: Color(0xff5a5a5a),
                ),
              ),
            ),
            Divider(color: Constants().defaultColor, thickness: 2),
            Text(
              "- สำเนาบัตรประชาชน",
              style: Constants().fontSarabunNormal(
                16,
                colorValue: Color(0xff7a7a7a),
              ),
            ),
            Text(
              "- สำเนาบัญชีธนาคารที่มีการเคลื่อนไหว",
              style: Constants().fontSarabunNormal(
                16,
                colorValue: Color(0xff7a7a7a),
              ),
            ),
            Text(
              "- สำเนาทะเบียนบ้าน",
              style: Constants().fontSarabunNormal(
                16,
                colorValue: Color(0xff7a7a7a),
              ),
            ),
            Text(
              "- เล่มรถ หรือ สำเนารถ",
              style: Constants().fontSarabunNormal(
                16,
                colorValue: Color(0xff7a7a7a),
              ),
            ),
            Text(
              "- สำเนาใบขับขี่",
              style: Constants().fontSarabunNormal(
                16,
                colorValue: Color(0xff7a7a7a),
              ),
            ),
            Text(
              "- รูปถ่ายบุคคล",
              style: Constants().fontSarabunNormal(
                16,
                colorValue: Color(0xff7a7a7a),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder borderStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Constants().defaultColor,
        width: 1,
      ),
    );
  }
}
