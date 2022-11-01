import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_test/models/nation/MasterBankModel.dart';
import 'package:project_test/models/nation/MasterProvinceModel.dart';
import 'package:project_test/services/api_path.dart';
import 'package:project_test/services/api_service.dart';
import 'package:project_test/utils/constant_value.dart';
import 'package:project_test/utils/dialogs.dart';
import 'package:project_test/utils/preferences.dart';
import 'package:image_picker/image_picker.dart';

class RigisterStep3Provider extends ChangeNotifier {
  RigisterStep3Provider();

  MasterBankModel? bankModel;
  MasterProvinceModel? provinceModel;

  List<String> provinceList = [], bankList = [];

  TextEditingController accoutNumBerContrl = TextEditingController();
  TextEditingController accoutNameContrl = TextEditingController();
  TextEditingController accoutPicContrl = TextEditingController();
  TextEditingController brandContrl = TextEditingController();
  TextEditingController modelContrl = TextEditingController();
  TextEditingController registContrl = TextEditingController();
  TextEditingController cardNumbPicContrl = TextEditingController();
  TextEditingController policyPicContrl = TextEditingController();

  bool bankSts = true,
      accoutNumbSts = true,
      accoutNameSts = true,
      accoutPicSts = true,
      brandSts = true,
      modelSts = true,
      registSts = true,
      provinceSts = true,
      cardNumbPicSts = true,
      policySts = true;

  List<int> radio = [0, 1];
  int grouRadio = 0, bankId = 0, provinceId = 0;
  XFile? file;
  String base64AccoutPic = '',
      bankText = '',
      provinceText = '',
      base64CardNumbPic = '',
      base64PolicyPic = '';

  intit() async {
    getProvide();
    getBank();
    getPreference();
  }

  getProvide() async {
    try {
      var jsonData = await RestAPI().postMethod(
          ApiPath().masterProvince,
          {
            // "trans_id": "11111111",
            "id": 0,
            "area_rider": "true",
          },
          isxxxxxx: false);

      provinceModel = MasterProvinceModel.fromJson(jsonData);
      provinceList = [];
      provinceModel!.result!.detailProvince!.forEach((element) {
        provinceList.add(element.stateName!);
      });

      notifyListeners();
    } catch (e) {
      Constants().printColorYellow('error masterProvince = $e');
    }
  }

  getBank() async {
    try {
      var jsonData = await RestAPI().postMethod(
          ApiPath().masterBank,
          {
            // "trans_id": "11111111",
            "id": 0,
          },
          isxxxxxx: false);

      bankModel = MasterBankModel.fromJson(jsonData);
      bankList = [];
      bankModel!.result!.detailBank!.forEach((element) {
        bankList.add(element.nameth!);
      });

      notifyListeners();
    } catch (e) {
      Constants().printColorYellow('error masterBank = $e');
    }
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

    if (flagPage == 'accoutPic') {
      accoutPicSts = true;
      base64AccoutPic = base64Encode(bytes);
      accoutPicContrl.text = file!.name;
    } else if (flagPage == 'cardNumbPic') {
      cardNumbPicSts = true;
      base64CardNumbPic = base64Encode(bytes);
      cardNumbPicContrl.text = file!.name;
    } else if (flagPage == 'policyPic') {
      policySts = true;
      base64PolicyPic = base64Encode(bytes);
      policyPicContrl.text = file!.name;
    }

    notifyListeners();
  }

  getPreference() {
    bankText = PreferenceUtils.getNtBank() ?? '';
    bankId = PreferenceUtils.getNtBankID() ?? 0;
    accoutNumBerContrl.text = PreferenceUtils.getNtAccoutNumb() ?? '';
    accoutNameContrl.text = PreferenceUtils.getNtAccoutName() ?? '';
    accoutPicContrl.text = PreferenceUtils.getNtAccoutPicName() ?? '';
    base64AccoutPic = PreferenceUtils.getNtAccoutPicBase64() ?? '';
    brandContrl.text = PreferenceUtils.getNtBrand() ?? '';
    modelContrl.text = PreferenceUtils.getNtModel() ?? '';
    registContrl.text = PreferenceUtils.getNtRegist() ?? '';
    provinceText = PreferenceUtils.getNtProvinceRegist() ?? '';
    grouRadio = int.parse(PreferenceUtils.getNtMyCarSts().toString());
    cardNumbPicContrl.text = PreferenceUtils.getNtCardNumbPicName() ?? '';
    base64CardNumbPic = PreferenceUtils.getNtCardNumbPicBase64() ?? '';
    policyPicContrl.text = PreferenceUtils.getNtPolicyName() ?? '';
    base64PolicyPic = PreferenceUtils.getNtPolicyBase64() ?? '';
  }

  setPreference() {
    PreferenceUtils.setNtBank(bankText);
    PreferenceUtils.setNtBankID(bankId);
    PreferenceUtils.setNtAccoutNumb(accoutNumBerContrl.text);
    PreferenceUtils.setNtAccoutName(accoutNameContrl.text);
    PreferenceUtils.setNtAccoutPicName(accoutPicContrl.text);
    PreferenceUtils.setNtAccoutPicBase64(base64AccoutPic);
    PreferenceUtils.setNtBrand(brandContrl.text);
    PreferenceUtils.setNtModel(modelContrl.text);
    PreferenceUtils.setNtRegist(registContrl.text);
    PreferenceUtils.setNtProvinceRegist(provinceText);
    PreferenceUtils.setNtProvinceRegistID(provinceId);
    PreferenceUtils.setNtMyCarSts(grouRadio.toString());
    PreferenceUtils.setNtCardNumbPicName(cardNumbPicContrl.text);
    PreferenceUtils.setNtCardNumbPicBase64(base64CardNumbPic);
    PreferenceUtils.setNtPolicyName(policyPicContrl.text);
    PreferenceUtils.setNtPolicyBase64(base64PolicyPic);
  }

  checkSelectDropDown(String flagPage, String value) {
    if (flagPage == 'bank') {
      selectBank(value);
    } else if (flagPage == 'province') {
      selectProvide(value);
    }
  }

  selectBank(String text) {
    DetailBank _data = bankModel!.result!.detailBank!
        .firstWhere((element) => element.nameth == text);
    bankId = int.parse(_data.id.toString());
    bankText = text;
    bankSts = true;
    notifyListeners();
  }

  selectProvide(String text) {
    provinceId = provinceModel!.result!.detailProvince!
        .firstWhere((element) => element.stateName == text)
        .id!;
    provinceText = text;
    provinceSts = true;
    notifyListeners();
  }

  changeStatusSelect(int? status) {
    grouRadio = status!;

    notifyListeners();
  }

  textOnchage(String flage) {
    switch (flage) {
      case 'accoutNumb':
        accoutNumbSts = true;
        break;
      case 'accoutName':
        accoutNameSts = true;
        break;
      case 'brand':
        brandSts = true;
        break;
      case 'model':
        modelSts = true;
        break;
      case 'regist':
        registSts = true;
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
      if (bankText.trim().isEmpty) {
        bankSts = false;
      } else if (accoutNumBerContrl.text.trim().isEmpty) {
        accoutNumbSts = false;
      } else if (accoutNameContrl.text.trim().isEmpty) {
        accoutNameSts = false;
      } else if (accoutPicContrl.text.trim().isEmpty) {
        accoutPicSts = false;
      } else if (brandContrl.text.trim().isEmpty) {
        brandSts = false;
      } else if (modelContrl.text.trim().isEmpty) {
        modelSts = false;
      } else if (registContrl.text.trim().isEmpty) {
        registSts = false;
      } else if (provinceText.trim().isEmpty) {
        provinceSts = false;
      } else if (cardNumbPicContrl.text.trim().isEmpty) {
        cardNumbPicSts = false;
      } else if (policyPicContrl.text.trim().isEmpty) {
        policySts = false;
      } else {
        setPreference();
        Navigator.pushNamed(context, '/registerStep4');
      }
      notifyListeners();
    }
  }
}
