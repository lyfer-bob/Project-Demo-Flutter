import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_test/models/nation/RegisterRiderModel.dart';
import 'package:project_test/services/api_path.dart';
import 'package:project_test/utils/constant_value.dart';
import 'package:project_test/utils/dialogs.dart';
import 'package:project_test/utils/preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../models/RegisterRiderModel.dart';

class RigisterStep4Provider extends ChangeNotifier {
  RigisterStep4Provider();

  TextEditingController cardNumbCtrl = new TextEditingController();
  TextEditingController cardCarCtrl = new TextEditingController();
  TextEditingController cardDriveCtrl = new TextEditingController();
  TextEditingController registHomeCtrl = new TextEditingController();
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController surNameCtrl = new TextEditingController();
  TextEditingController phoneCtrl = new TextEditingController();
  TextEditingController realatCtrl = new TextEditingController();

  RegisterRiderModel registerModel = new RegisterRiderModel();

  bool cardNumbSts = true,
      cardCarSts = true,
      cardDriveSts = true,
      registHomeSts = true,
      nameSts = true,
      surNameSts = true,
      phoneSts = true,
      realatSts = true;

  bool checkBoxConsent1 = false,
      checkBoxConsent2 = false,
      checkBoxConsent3 = false,
      checkBoxBody = false,
      checkBoxCondition1 = false,
      checkBoxCondition2 = false,
      checkBoxCondition3 = false,
      checkBoxTitle = false,
      checkBoxCall = false,
      checkBoxEmail = false,
      checkBoxNoti = false,
      checkBoxNoMessage = false,
      checkBoxOther = false;

  XFile? file;
  String base64CardNumbPic = '',
      base64CardCarPic = '',
      base64CardDrivePic = '',
      base64RegistPic = '';

  intit() {
    getPreference();
  }

  setCheckBox(bool value, String callBy) {
    if (callBy == 'consent1') {
      checkBoxConsent1 = value;
    } else if (callBy == 'consent2') {
      checkBoxConsent2 = value;
    } else if (callBy == 'consent3') {
      checkBoxConsent3 = value;
    } else if (callBy == 'body') {
      checkBoxBody = value;
    } else if (callBy == 'Condition1') {
      checkBoxCondition1 = value;
    } else if (callBy == 'Condition2') {
      checkBoxCondition2 = value;
    } else if (callBy == 'Condition3') {
      checkBoxCondition3 = value;
    } else if (callBy == 'title') {
      checkBoxTitle = value;
      if (!checkBoxTitle) {
        checkBoxCall = false;
        checkBoxEmail = false;
        checkBoxNoti = false;
        checkBoxNoMessage = false;
      } else {
        checkBoxCall = true;
        checkBoxEmail = true;
        checkBoxNoti = true;
        checkBoxNoMessage = false;
      }
    } else if (callBy == 'call') {
      checkBoxCall = value;
      checkBoxNoMessage = false;
    } else if (callBy == 'email') {
      checkBoxEmail = value;
      checkBoxNoMessage = false;
    } else if (callBy == 'noti') {
      checkBoxNoti = value;
      checkBoxNoMessage = false;
    } else if (callBy == 'noMessage') {
      checkBoxNoMessage = value;
      if (checkBoxNoMessage) {
        checkBoxTitle = false;
        checkBoxCall = false;
        checkBoxEmail = false;
        checkBoxNoti = false;
      }
    } else if (callBy == 'other') {
      checkBoxOther = value;
    }
    notifyListeners();
  }

  getFileAndNameImage(String flagPage) async {
    final ImagePicker _picker = ImagePicker();
    file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 250,
      maxHeight: 250,
    );

    final bytes = File(file!.path).readAsBytesSync();

    if (flagPage == 'cardNumbPic') {
      cardNumbSts = true;
      base64CardNumbPic = base64Encode(bytes);
      cardNumbCtrl.text = file!.name;
    } else if (flagPage == 'cardCarPic') {
      cardCarSts = true;
      base64CardCarPic = base64Encode(bytes);
      cardCarCtrl.text = file!.name;
    } else if (flagPage == 'cardDrivePic') {
      cardDriveSts = true;
      base64CardDrivePic = base64Encode(bytes);
      cardDriveCtrl.text = file!.name;
    } else if (flagPage == 'registHomePic') {
      registHomeSts = true;
      base64RegistPic = base64Encode(bytes);
      registHomeCtrl.text = file!.name;
    }

    notifyListeners();
  }

  getPreference() {
    cardNumbCtrl.text = PreferenceUtils.getNtCardNumbName() ?? '';
    base64CardNumbPic = PreferenceUtils.getNtCardNumbBase64() ?? '';
    cardCarCtrl.text = PreferenceUtils.getNtCardCarName() ?? '';
    base64CardCarPic = PreferenceUtils.getNtCardCarBase64() ?? '';
    cardDriveCtrl.text = PreferenceUtils.getNtCardDriveName() ?? '';
    base64CardDrivePic = PreferenceUtils.getNtCardDriveBase64() ?? '';
    registHomeCtrl.text = PreferenceUtils.getNtRegistHomeName() ?? '';
    base64RegistPic = PreferenceUtils.getNtRegistHomeBase64() ?? '';

    nameCtrl.text = PreferenceUtils.getNtNameRef() ?? '';
    surNameCtrl.text = PreferenceUtils.getNtSurNameRef() ?? '';
    phoneCtrl.text = PreferenceUtils.getNtPhoneRef() ?? '';
    realatCtrl.text = PreferenceUtils.getNtRealatRef() ?? '';

    checkBoxConsent1 = PreferenceUtils.getNtCheckBoxConsent1() ?? false;
    checkBoxConsent2 = PreferenceUtils.getNtCheckBoxConsent2() ?? false;
    checkBoxConsent3 = PreferenceUtils.getNtCheckBoxConsent3() ?? false;
    checkBoxBody = PreferenceUtils.getNtCheckBoxBody() ?? false;
    checkBoxCondition1 = PreferenceUtils.getNtCheckBoxCondition1() ?? false;
    checkBoxCondition2 = PreferenceUtils.getNtCheckBoxCondition2() ?? false;
    checkBoxCondition3 = PreferenceUtils.getNtCheckBoxCondition3() ?? false;
    checkBoxTitle = PreferenceUtils.getNtCheckBoxTitle() ?? false;
    checkBoxCall = PreferenceUtils.getNtCheckBoxCall() ?? false;
    checkBoxEmail = PreferenceUtils.getNtCheckBoxEmail() ?? false;
    checkBoxNoti = PreferenceUtils.getNtCheckBoxNoti() ?? false;
    checkBoxNoMessage = PreferenceUtils.getNtCheckBoxNoMessage() ?? false;
    checkBoxOther = PreferenceUtils.getNtCheckBoxOther() ?? false;
  }

  setPreference() {
    PreferenceUtils.setNtCardNumbName(cardNumbCtrl.text);
    PreferenceUtils.setNtCardNumbBase64(base64CardNumbPic);
    PreferenceUtils.setNtCardCarName(cardCarCtrl.text);
    PreferenceUtils.setNtCardCarBase64(base64CardCarPic);
    PreferenceUtils.setNtCardDriveName(cardDriveCtrl.text);
    PreferenceUtils.setNtCardDriveBase64(base64CardDrivePic);
    PreferenceUtils.setNtRegistHomeName(registHomeCtrl.text);
    PreferenceUtils.setNtRegistHomeBase64(base64RegistPic);

    PreferenceUtils.setNtNameRef(nameCtrl.text);
    PreferenceUtils.setNtSurNameRef(surNameCtrl.text);
    PreferenceUtils.setNtPhoneRef(phoneCtrl.text);
    PreferenceUtils.setNtRealatRef(realatCtrl.text);

    PreferenceUtils.setNtCheckBoxConsent1(checkBoxConsent1);
    PreferenceUtils.setNtCheckBoxConsent2(checkBoxConsent2);
    PreferenceUtils.setNtCheckBoxConsent3(checkBoxConsent3);
    PreferenceUtils.setNtCheckBoxBody(checkBoxBody);
    PreferenceUtils.setNtCheckBoxCondition1(checkBoxCondition1);
    PreferenceUtils.setNtCheckBoxCondition2(checkBoxCondition2);
    PreferenceUtils.setNtCheckBoxCondition3(checkBoxCondition3);
    PreferenceUtils.setNtCheckBoxTitle(checkBoxTitle);
    PreferenceUtils.setNtCheckBoxCall(checkBoxCall);
    PreferenceUtils.setNtCheckBoxEmail(checkBoxEmail);
    PreferenceUtils.setNtCheckBoxNoti(checkBoxNoti);
    PreferenceUtils.setNtCheckBoxNoMessage(checkBoxNoMessage);
    PreferenceUtils.setNtCheckBoxOther(checkBoxOther);
  }

  textOnchage(String flage) {
    switch (flage) {
      case 'name':
        nameSts = true;
        break;
      case 'surName':
        surNameSts = true;
        break;
      case 'phone':
        phoneSts = true;
        break;
      case 'realat':
        realatSts = true;
        break;

      default:
    }

    notifyListeners();
  }

  actionSubmit(BuildContext context, String flag) {
    if (flag == 'save') {
      setPreference();
      normalDialog(context, 'บันทึกสำเร็จ');
    } else {
      if (cardNumbCtrl.text.trim().isEmpty) {
        cardNumbSts = false;
      } else if (cardCarCtrl.text.trim().isEmpty) {
        cardCarSts = false;
      } else if (cardDriveCtrl.text.trim().isEmpty) {
        cardDriveSts = false;
      } else if (registHomeCtrl.text.trim().isEmpty) {
        registHomeSts = false;
      } else if (nameCtrl.text.trim().isEmpty) {
        nameSts = false;
      } else if (surNameCtrl.text.trim().isEmpty) {
        surNameSts = false;
      } else if (phoneCtrl.text.trim().isEmpty) {
        phoneSts = false;
      } else if (realatCtrl.text.trim().isEmpty) {
        realatSts = false;
      } else if (!checkBoxConsent1 ||
          !checkBoxConsent2 ||
          !checkBoxConsent3 ||
          !checkBoxBody ||
          !checkBoxCondition1 ||
          !checkBoxCondition2 ||
          !checkBoxCondition3) {
        normalDialog(context, 'กรุณายินยอมให้ครบทุกข้อ');
      } else if (!checkBoxCall &&
          !checkBoxEmail &&
          !checkBoxNoti &&
          !checkBoxNoMessage) {
        normalDialog(context, 'กรุณารับข้อเสนออย่างน้อย 1 ข้อ');
      } else {
        normalDialog2(context, 'คุณต้องการที่จะส่งข้อมูลใช่หรือไม่',
            dialogYesNo: true, onPressed: () {
          Navigator.pop(context);
          setPreference();

          sendRegister(context);
        });
      }
      notifyListeners();
    }
  }

  sendRegister(BuildContext context) {
    registerModel.registerId = PreferenceUtils.getRegisterId() ?? '';
    registerModel.action = 'save';
    registerModel.registerChannel = 'MOBILE';
    registerModel.transId = DateTime.now().toString();
    registerModel.profile = Profile(
      email: PreferenceUtils.getNtEmail(),
      imgRider: formatBase64(PreferenceUtils.getNtBase64PicRider()!),
      titleName: PreferenceUtils.getNtTiltleName(),
      firstName: PreferenceUtils.getNtName(),
      lastName: PreferenceUtils.getNtSurName(),
      iDcard: PreferenceUtils.getNtCardNumb(),
      gender: sexData(PreferenceUtils.getNtSex() ?? 'ชาย'),
      birthday: PreferenceUtils.getNtBirthDate(),
      age: PreferenceUtils.getNtAge()!.replaceAll('ปี', '').trim(),
      phone: PreferenceUtils.getNtPhoneNumber(),
      riderBill: riderBillData(PreferenceUtils.getNtRiderBill()!),
      home: PreferenceUtils.getNtAddressNumb(),
      building: PreferenceUtils.getNtMooban(),
      tumbol: PreferenceUtils.getNtTumbolID(),
      amphur: PreferenceUtils.getNtAumpurID(),
      province: PreferenceUtils.getNtProvinceID(),
      zipcode: PreferenceUtils.getNtPostOff(),
      cardHome: PreferenceUtils.getNtAddressNumb2(),
      cardBuilding: PreferenceUtils.getNtMooban2(),
      cardTumbol: PreferenceUtils.getNtTumbolID2(),
      cardAmphur: PreferenceUtils.getNtAumpurID2(),
      cardProvince: PreferenceUtils.getNtProvinceID2(),
      cardZipcode: PreferenceUtils.getNtPostOff2(),
      bank: PreferenceUtils.getNtBankID(),
      bankNumber: PreferenceUtils.getNtAccoutNumb(),
      bankName: PreferenceUtils.getNtAccoutName(),
      bookbank: formatBase64(PreferenceUtils.getNtAccoutPicBase64()!),
      carBrand: PreferenceUtils.getNtBrand(),
      carModel: PreferenceUtils.getNtModel(),
      carNumber: PreferenceUtils.getNtRegist(),
      carProvince: PreferenceUtils.getNtProvinceRegistID(),
      fileIdentity: formatBase64(PreferenceUtils.getNtCardNumbBase64()!),
      fileCar: formatBase64(PreferenceUtils.getNtCardCarBase64()!),
      fileHome: formatBase64(PreferenceUtils.getNtRegistHomeBase64()!),
      fileDriverLicense: formatBase64(PreferenceUtils.getNtCardDriveBase64()!),
      fileAcceptOwnerCare: checkOwner(PreferenceUtils.getNtPolicyBase64()!),
      fileOwnerIdentity: checkOwner(PreferenceUtils.getNtCardNumbPicBase64()!),
      ownerCar: PreferenceUtils.getNtMyCarSts() == '0' ? "Y" : "N",
      idcardActivateDate: PreferenceUtils.getNtCardDate(),
      idcardExpiredDate: PreferenceUtils.getNtCardExpDate(),
      packageTool: PreferenceUtils.getNtPackageBuy() ?? '',
      acceptList: acceptListPolicy(),
      termsConditionsNews: accepttermsConditionsNews(),
      acceptNews: acceptListNews(),
      additionalIncome: checkBoxOther ? '13' : '',
      contactFName: PreferenceUtils.getNtNameRef() ?? '',
      contactLName: PreferenceUtils.getNtSurNameRef() ?? '',
      contactPhone: PreferenceUtils.getNtPhoneRef() ?? '',
      contactRelationship: PreferenceUtils.getNtRealatRef() ?? '',
    );
    registerModel.area =
        Area(provinceId: PreferenceUtils.getNtAreapicker() ?? '');

    // print('json = ${formatBase64(PreferenceUtils.getNtCardCarBase64()!)}');
    sendRegisterApi(context);
  }

  sendRegisterApi(BuildContext context) async {
    try {
      var jsonData = await RestAPI().postMethod(
          ApiPath().registerRider, registerModel.toJson(),
          isxxxxxx: false);
      String _value = jsonData['response']['result']['message'].toString();
      Constants().printColorYellow(_value);

      if (jsonData['response']['result']['success'].toString() == '0') {
        normalDialog(context, jsonData['response']['result']['message']);
      } else {
        normalDialog2(
          context,
          jsonData['response']['result']['message'],
          onPressed: () {
            clearPreference();

            Navigator.popUntil(context, ModalRoute.withName('/logIn'));
          },
        );
      }
      notifyListeners();
    } catch (e) {
      print('errormaster Equipment = $e');
    }
  }

  String formatBase64(String data) => 'data:image/jpeg;base64,$data';

  String checkOwner(String data) {
    print('base64 = $data');
    return PreferenceUtils.getNtMyCarSts() == '0'
        ? ""
        : 'data:image/jpeg;base64,$data';
  }

  String acceptListNews() {
    String _condi1 = checkBoxCall ? '9,' : '';
    String _condi2 = checkBoxEmail ? '10,' : '';
    String _condi3 = checkBoxNoti ? '11,' : '';
    String _condi4 = checkBoxNoMessage ? '12,' : '';

    String value = _condi1 + _condi2 + _condi3 + _condi4;

    if (!checkBoxNoMessage) value = '8,$value';

    return value.trim().substring(0, value.length - 1);
  }

  String accepttermsConditionsNews() {
    String _condi1 = checkBoxCondition1 ? ',5' : '';
    String _condi2 = checkBoxCondition2 ? ',6' : '';
    String _condi3 = checkBoxCondition3 ? ',7' : '';

    String value = _condi1 + _condi2 + _condi3;

    return value.trim().substring(1);
  }

  String acceptListPolicy() {
    String _condi1 = checkBoxConsent1 ? '1,' : '';
    String _condi2 = checkBoxConsent2 ? '2,' : '';
    String _condi3 = checkBoxConsent3 ? '3,' : '';
    String _condi4 = checkBoxBody ? '4,' : '';

    String value = _condi1 + _condi2 + _condi3 + _condi4;

    return value.trim().substring(0, value.length - 1);
  }

  Future<String> tests() async {
    return '1';
  }

  String sexData(String value) => value == 'ชาย'
      ? 'M'
      : value == "หญิง"
          ? 'F'
          : '';

  int riderBillData(String value) {
    int _data = 0;
    if (value == 'รอบครึ่งวัน')
      _data = 0;
    else if (value == 'รอบวัน')
      _data = 1;
    else if (value == 'รอบสัปดาห์')
      _data = 2;
    else
      _data = 3;

    return _data;
  }

  clearPreference() {
    //step1
    PreferenceUtils.setNtRegisterId('');

    PreferenceUtils.setNtBase64PicRider('');
    PreferenceUtils.setNtTiltleName('นาย');
    PreferenceUtils.setNtName('');
    PreferenceUtils.setNtSurName('');
    PreferenceUtils.setNtCardNumb('');
    PreferenceUtils.setNtCardDate('');
    PreferenceUtils.setNtCardExpDate('');
    PreferenceUtils.setNtSex('ชาย');
    PreferenceUtils.setNtBirthDate('');
    PreferenceUtils.setNtAge('');
    PreferenceUtils.setNtRiderBill('รอบครึ่งวัน');
    PreferenceUtils.setNtPhoneNumber('');
    PreferenceUtils.setNtEmail('');

    //step2
    PreferenceUtils.setNtAddressNumb('');
    PreferenceUtils.setNtMooban('');
    PreferenceUtils.setNtProvince('');
    PreferenceUtils.setNtAumpur('');
    PreferenceUtils.setNtTumbol('');
    PreferenceUtils.setNtPostOff('');
    PreferenceUtils.setNtSelectAddressSame(false);
    PreferenceUtils.setNtAddressNumb2('');
    PreferenceUtils.setNtMooban2('');
    PreferenceUtils.setNtProvince2('');
    PreferenceUtils.setNtAumpur2('');
    PreferenceUtils.setNtTumbol2('');
    PreferenceUtils.setNtPostOff2('');
    PreferenceUtils.setNtAreapicker('');
    PreferenceUtils.setNtPackageBuy('');
    PreferenceUtils.setNtProvinceID(0);
    PreferenceUtils.setNtAumpurID(0);
    PreferenceUtils.setNtTumbolID(0);
    PreferenceUtils.setNtProvinceID2(0);
    PreferenceUtils.setNtAumpurID2(0);
    PreferenceUtils.setNtTumbolID2(0);

    //step3
    PreferenceUtils.setNtBank('');
    PreferenceUtils.setNtBankID(0);
    PreferenceUtils.setNtAccoutNumb('');
    PreferenceUtils.setNtAccoutName('');
    PreferenceUtils.setNtAccoutPicName('');
    PreferenceUtils.setNtAccoutPicBase64('');
    PreferenceUtils.setNtBrand('');
    PreferenceUtils.setNtModel('');
    PreferenceUtils.setNtRegist('');
    PreferenceUtils.setNtProvinceRegist('');
    PreferenceUtils.setNtProvinceRegistID(0);
    PreferenceUtils.setNtMyCarSts('0');
    PreferenceUtils.setNtCardNumbPicName('');
    PreferenceUtils.setNtCardNumbPicBase64('');
    PreferenceUtils.setNtPolicyName('');
    PreferenceUtils.setNtPolicyBase64('');

    //step4
    PreferenceUtils.setNtCardNumbName('');
    PreferenceUtils.setNtCardNumbBase64('');
    PreferenceUtils.setNtCardCarName('');
    PreferenceUtils.setNtCardCarBase64('');
    PreferenceUtils.setNtCardDriveName('');
    PreferenceUtils.setNtCardDriveBase64('');
    PreferenceUtils.setNtRegistHomeName('');
    PreferenceUtils.setNtRegistHomeBase64('');
    PreferenceUtils.setNtNameRef('');
    PreferenceUtils.setNtSurNameRef('');
    PreferenceUtils.setNtPhoneRef('');
    PreferenceUtils.setNtRealatRef('');
    PreferenceUtils.setNtCheckBoxConsent1(false);
    PreferenceUtils.setNtCheckBoxConsent2(false);
    PreferenceUtils.setNtCheckBoxConsent3(false);
    PreferenceUtils.setNtCheckBoxBody(false);
    PreferenceUtils.setNtCheckBoxCondition1(false);
    PreferenceUtils.setNtCheckBoxCondition2(false);
    PreferenceUtils.setNtCheckBoxCondition3(false);
    PreferenceUtils.setNtCheckBoxTitle(false);
    PreferenceUtils.setNtCheckBoxCall(false);
    PreferenceUtils.setNtCheckBoxEmail(false);
    PreferenceUtils.setNtCheckBoxNoti(false);
    PreferenceUtils.setNtCheckBoxNoMessage(false);
    PreferenceUtils.setNtCheckBoxOther(false);
  }
}
