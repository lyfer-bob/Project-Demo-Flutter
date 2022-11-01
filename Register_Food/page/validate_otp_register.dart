import 'package:flutter/material.dart';
import 'package:project_test/blocs/Login_provider.dart';
import 'package:project_test/blocs/globalURL_provider.dart';
import 'package:project_test/blocs/nation/register_otp_provider.dart';
import 'package:project_test/services/api_path.dart';
import 'package:project_test/utils/constant_value.dart';
import 'package:project_test/widgets/buttonAccept.dart';
import 'package:provider/provider.dart';

class ValidateRegister extends StatefulWidget {
  const ValidateRegister({Key? key}) : super(key: key);

  @override
  State<ValidateRegister> createState() => _ValidateRegisterState();
}

class _ValidateRegisterState extends State<ValidateRegister> {
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
                containerValidate(context),
                containerDetail(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container containerValidate(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 25),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 10),
        child: Consumer3<LoginProvider, GlobalURLProvider, RegisterOTPProvider>(
          builder:
              (context, loginPvd, globalURLProviderValue, regisOTPPvd, child) =>
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
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'กรุณากรอกหมายเลข OTP ที่ส่งไปยัง\nหมายเลข : ${regisOTPPvd.phoneController.text}\n[Ref : ${regisOTPPvd.registerREFCODE}]',
                    textAlign: TextAlign.center,
                    style: Constants().fontSarabunNormal(
                      16,
                      colorValue: Color(0xff3d525c),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'รหัส OTP',
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
              btnSubmit(context),
              callOTPagain(),
              Container(
                margin: EdgeInsets.only(top: 20),
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

  Container callOTPagain() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () {
          Provider.of<RegisterOTPProvider>(context, listen: false)
              .requestRegisterOTP()
              .whenComplete(
            () {
              Provider.of<RegisterOTPProvider>(context, listen: false)
                  .clearDataHolder('validateController');

              Constants().printColorMagenta('requestRegisterOTP Again');
            },
          );
        },
        child: Text(
          'ขอรหัส OTP อีกครั้ง ?',
          style: TextStyle(
              decoration: TextDecoration.underline,
              fontFamily: 'Sarabun',
              fontSize: 13,
              fontWeight: FontWeight.normal,
              color: Constants().textColor),
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
            controller: regisOTPPvd.validateController,
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
              regisOTPPvd.validateController.text = newValue;
              if (newValue.length == 6) {
                regisOTPPvd.setlengthNumberValidate(true);
              } else {
                regisOTPPvd.setlengthNumberValidate(false);
              }
              regisOTPPvd.validateController.selection =
                  TextSelection.fromPosition(TextPosition(
                      offset: regisOTPPvd.validateController.text.length));
            },
            maxLength: 6,
            autocorrect: false,
            // inputFormatters: [
            //   MaskedInputFormatter('###-###-####'),
            // ],
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
          onPressed: regisOTPPvd.checklengthNumberValidate
              ? () {
                  if (regisOTPPvd.checklengthNumberValidate) {
                    print('${regisOTPPvd.validateController.text}');

                    regisOTPPvd.verifyRegisterOTP(
                      context,
                      regisOTPPvd.validateController.text,
                      regisOTPPvd.registerREFCODE.toString(),
                    );
                    //Navigator.pushNamed(context, '/register');
                  }
                }
              : null,
          text: 'ยืนยัน',
          height: 50,
          fontColor: Colors.white,
          fontSize: 16,
          backgroundColor: regisOTPPvd.checklengthNumberValidate
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
