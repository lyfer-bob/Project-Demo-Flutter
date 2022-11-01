import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_test/utils/dialogs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../utils/preferences.dart';

class RigisterStep1Provider extends ChangeNotifier {
  RigisterStep1Provider();

  List<String> titleName = ["นาย", "นาง", "นางสาว", "ไม่ระบุ"];
  List<String> sex = ["ชาย", "หญิง", "ไม่ระบุ"];
  List<String> riderBill = ['รอบครึ่งวัน', 'รอบวัน', 'รอบสัปดาห์', 'รอบเดือน'];

  TextEditingController ageContrl = TextEditingController();
  TextEditingController nameContrl = TextEditingController();
  TextEditingController surNameContrl = TextEditingController();
  TextEditingController cardNumbContrl = TextEditingController();
  TextEditingController cardDateContrl = TextEditingController();
  TextEditingController cardExpDateContrl = TextEditingController();
  TextEditingController birthDateContrl = TextEditingController();
  TextEditingController phoneContrl = TextEditingController();
  TextEditingController emailContrl = TextEditingController();
  List<int> radio = [0, 1];

  DateTime? dateCard, dateCardExp;
  XFile? image;
  String textValidEmail = '';
  String base64 = '', titleText = '', sexText = '', riderBillText = '';
  bool nameStsChange = false,
      surNameStsChange = false,
      cardNumbStsChange = false,
      cardDateStsChange = false,
      cardExpDateStsChange = false,
      birthDateStsChange = false,
      phoneStsChange = false,
      emailStsChange = false;
  intit() async {
    nameStsChange = true;
    surNameStsChange = true;
    cardNumbStsChange = true;
    cardDateStsChange = true;
    cardExpDateStsChange = true;
    birthDateStsChange = true;
    phoneStsChange = true;
    emailStsChange = true;
    getPreference();
  }

  getPreference() {
    base64 = PreferenceUtils.getNtBase64PicRider() ?? '';
    titleText = PreferenceUtils.getNtTiltleName() ?? titleName.first;
    nameContrl.text = PreferenceUtils.getNtName() ?? '';
    surNameContrl.text = PreferenceUtils.getNtSurName() ?? '';
    cardNumbContrl.text = PreferenceUtils.getNtCardNumb() ?? '';
    cardDateContrl.text = PreferenceUtils.getNtCardDate() ?? '';
    cardExpDateContrl.text = PreferenceUtils.getNtCardExpDate() ?? '';
    sexText = PreferenceUtils.getNtSex() ?? sex.first;
    birthDateContrl.text = PreferenceUtils.getNtBirthDate() ?? '';
    ageContrl.text = PreferenceUtils.getNtAge() ?? '';
    riderBillText = PreferenceUtils.getNtRiderBill() ?? riderBill.first;
    phoneContrl.text = PreferenceUtils.getNtPhoneNumber() ?? '';
    emailContrl.text = PreferenceUtils.getNtEmail() ?? '';
  }

  setPreference() {
    PreferenceUtils.setNtBase64PicRider(base64);
    PreferenceUtils.setNtTiltleName(titleText);
    PreferenceUtils.setNtName(nameContrl.text);
    PreferenceUtils.setNtSurName(surNameContrl.text);
    PreferenceUtils.setNtCardNumb(cardNumbContrl.text);
    PreferenceUtils.setNtCardDate(cardDateContrl.text);
    PreferenceUtils.setNtCardExpDate(cardExpDateContrl.text);
    PreferenceUtils.setNtSex(sexText);
    PreferenceUtils.setNtBirthDate(birthDateContrl.text);
    PreferenceUtils.setNtAge(ageContrl.text);
    PreferenceUtils.setNtRiderBill(riderBillText);
    PreferenceUtils.setNtPhoneNumber(phoneContrl.text);
    PreferenceUtils.setNtEmail(emailContrl.text);
  }

  selectImage(context) async {
    final ImagePicker _picker = ImagePicker();

    image = await _picker.pickImage(source: ImageSource.gallery);
    final bytes = File(image!.path).readAsBytesSync();
    int bytesData = File(image!.path).readAsBytesSync().lengthInBytes;

    final kb = bytesData / 1024;
    final mb = kb / 1024;

    if (mb > 3)
      normalDialog(context, 'รูปมีขนาดใหญ่เกินไปกรุณาลองใหม่อีกครั้ง');
    else
      base64 = base64Encode(bytes);

    notifyListeners();
  }

  checkSelectDropDown(String flag, String value) {
    if (flag == 'title')
      titleText = value;
    else if (flag == 'sex')
      sexText = value;
    else if (flag == 'riderbill') riderBillText = value;

    notifyListeners();
  }

  textOnchage(String flage) {
    switch (flage) {
      case 'name':
        nameStsChange = true;
        break;
      case 'surname':
        surNameStsChange = true;
        break;
      case 'cardNumb':
        cardNumbStsChange = true;
        break;
      case 'phone':
        phoneStsChange = true;
        break;
      case 'email':
        emailStsChange = true;
        break;

      default:
    }
    notifyListeners();
  }

  String convertDate(String value) {
    String _value = '';
    if (value.isEmpty) {
      _value = '';
    } else {
      List<String> date = value.split('-');
      _value = '${date[2]}/${date[1]}/${int.parse(date[0]) + 543}';
    }
    return _value;
  }

  onchangDate(String value, String flag, BuildContext context) {
    print('value = $value , flage $flag');
    if (flag == 'active') {
      getCardDate(value);
    } else if (flag == 'exp') {
      getCardExpDate(value, context);
    } else if (flag == 'birthdate') {
      getBirthDate(value, context);
    }
  }

  getCardDate(String value) {
    print('intiitt === $value');
    DateTime date = DateFormat("yyyy-MM-dd").parse(value.trim());
    dateCard = date;
    cardDateStsChange = true;
    cardDateContrl.text = convertDate(value);
    cardExpDateContrl.text = '';
    print('object == ${cardDateContrl.text.toString()}');
    notifyListeners();
  }

  getCardExpDate(String value, BuildContext context) {
    DateTime date = new DateFormat("yyyy-MM-dd").parse(value.trim());
    dateCardExp = date;

    if (dateCard != null) {
      if (dateCardExp!.compareTo(dateCard!) > 0) {
        cardExpDateContrl.text = convertDate(value);
        cardExpDateStsChange = true;
      } else {
        normalDialog(
            context, 'วันที่หมดอายุมากกว่าวันออกบัตร กรุณากรอกใหม่อีกครั้ง');
        cardExpDateContrl.text = '';
      }
    } else {
      normalDialog(context, 'กรุณากรอกวันออกบัตรก่อน');
    }

    notifyListeners();
  }

  getBirthDate(String value, BuildContext context) {
    int birthYear = int.parse(value.split('-')[0]);
    int nowYear = int.parse(DateFormat('yyyy').format(DateTime.now()));

    if (nowYear - birthYear <= 0) {
      normalDialog(
          context, 'อายุผู้ใช้งานน้อยเกินไป กรุณาเลือกวันเกิดใหม่อีกครั้ง');
    } else {
      ageContrl.text = '${nowYear - birthYear} ปี';
      birthDateStsChange = true;
      birthDateContrl.text = convertDate(value);
    }
    notifyListeners();
  }

  actionSubmit(BuildContext context, String flag) {
    if (flag == 'save') {
      setPreference();
      normalDialog(context, 'บันทึกสำเร็จ');
    } else {
      if (base64.trim().isEmpty) {
        normalDialog(context, 'กรุณาเพิ่มรูปไรเดอร์');
      } else if (nameContrl.text.trim().isEmpty) {
        nameStsChange = false;
      } else if (surNameContrl.text.trim().isEmpty) {
        surNameStsChange = false;
      } else if (cardNumbContrl.text.trim().isEmpty) {
        cardNumbStsChange = false;
      } else if (cardDateContrl.text.trim().isEmpty) {
        cardDateStsChange = false;
      } else if (cardExpDateContrl.text.trim().isEmpty) {
        cardExpDateStsChange = false;
      } else if (birthDateContrl.text.trim().isEmpty) {
        birthDateStsChange = false;
      } else if (phoneContrl.text.trim().isEmpty) {
        phoneStsChange = false;
      } else if (emailContrl.text.trim().isEmpty) {
        textValidEmail = 'กรุณากรอกอีเมล';
        emailStsChange = false;
      } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailContrl.text.trim())) {
        textValidEmail = 'กรุณากรอกอีเมลให้ถุกต้อง';
        emailStsChange = false;
      } else {
        setPreference();
        Navigator.pushNamed(context, '/registerStep2');
      }

      notifyListeners();
    }
  }
}
