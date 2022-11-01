import 'package:flutter/material.dart';
import 'package:project_test/models/nation/MasterAmphurModel.dart';
import 'package:project_test/models/nation/MasterEquipmentModel.dart';
import 'package:project_test/models/nation/MasterProvinceModel.dart';
import 'package:project_test/models/nation/MasterTumbolModel.dart';
import 'package:project_test/services/api_path.dart';
import 'package:project_test/services/api_service.dart';
import 'package:project_test/utils/dialogs.dart';
import 'package:project_test/utils/preferences.dart';

class RigisterStep2Provider extends ChangeNotifier {
  RigisterStep2Provider();

  MasterProvinceModel? provinceModel;
  MasterAmphurModel? amphurModel;
  MasterTumbolModel? tumbolModel;
  MasterEquipmentModel? equipmentModel;

  List<String> provinceList = [],
      aumpurList = [],
      tumbolList = [],
      aumpurList2 = [],
      tumbolList2 = [];

  TextEditingController addrsNumbCtrl = TextEditingController();
  TextEditingController mooBanCtrl = TextEditingController();
  TextEditingController postOffCtrl = TextEditingController();
  String provinceText = '', aumpurText = '', tumbolText = '';

  TextEditingController addrsNumbCtrl2 = TextEditingController();
  TextEditingController mooBanCtrl2 = TextEditingController();
  TextEditingController postOffCtrl2 = TextEditingController();
  String provinceText2 = '', aumpurText2 = '', tumbolText2 = '';

  int? provinceId, aumpurId, tumbolID;
  int? provinceId2, aumpurId2, tumbolID2;
  List<int> radio = [0, 1];
  bool selectAddressSameSts = false;

  bool addrsNumbSts = false,
      mooBanSts = false,
      postOffSts = false,
      provinceSts = false,
      aumpurSts = false,
      tumbolSts = false,
      addrsNumbSts2 = false,
      mooBanSts2 = false,
      postOffSts2 = false,
      provinceSts2 = false,
      aumpurSts2 = false,
      tumbolSts2 = false;

  bool stsAumpurEnable = false,
      stsTumbolEnable = false,
      stsAumpurEnable2 = false,
      stsTumbolEnable2 = false,
      stsAddrsNumb2Enable = false,
      stsMooBan2Enable = false,
      stsPostOffSts2Enable = false,
      stsProvinceSts2Enable = false;

  intit() async {
    addrsNumbSts = true;
    mooBanSts = true;
    postOffSts = true;
    provinceSts = true;
    aumpurSts = true;
    tumbolSts = true;
    addrsNumbSts2 = true;
    mooBanSts2 = true;
    postOffSts2 = true;
    provinceSts2 = true;
    aumpurSts2 = true;
    tumbolSts2 = true;
    stsAddrsNumb2Enable = true;
    stsMooBan2Enable = true;
    stsPostOffSts2Enable = true;
    stsProvinceSts2Enable = true;

    getEquipment();
    await getProvide();
    getPreference();
  }

  getEquipment() async {
    try {
      var jsonData = await RestAPI().postMethod(
          ApiPath().masterEquipment,
          {
            // "trans_id": "11111111",
            "ItemID": 0,
          },
          isxxxxxx: false);

      equipmentModel = MasterEquipmentModel.fromJson(jsonData);
      equipmentModel!.response!.detailEquipment!.forEach((element) {
        element.itemStatus = "False";
      });
      notifyListeners();
    } catch (e) {
      print('errormaster Equipment = $e');
    }
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
        element.status = '0';
        provinceList.add(element.stateName!);
      });

      notifyListeners();
    } catch (e) {
      print('errormasterProvince = $e');
    }
  }

  getAumpur() async {
    try {
      var jsonData = await RestAPI().postMethod(
          ApiPath().masterAmphur,
          {
            // "trans_id": "11111111",
            "state_id": provinceId
          },
          isxxxxxx: false);

      amphurModel = MasterAmphurModel.fromJson(jsonData);

      amphurModel!.result!.detailDistrict!.forEach((element) {
        aumpurList.add(element.cityName!);
      });
      notifyListeners();
    } catch (e) {
      print('errormasterAumphur = $e');
    }
  }

  getTumbol() async {
    try {
      var jsonData = await RestAPI().postMethod(
          ApiPath().masterTumbol,
          {
            // "trans_id": "11111111",
            // "id": 0,
            "city_id": aumpurId,
            "state_id": provinceId,
          },
          isxxxxxx: false);

      tumbolModel = MasterTumbolModel.fromJson(jsonData);
      tumbolModel!.result!.detailSubDistrict!.forEach((element) {
        tumbolList.add(element.areaName!);
      });
      notifyListeners();
    } catch (e) {
      print('errormasterTambol = $e');
    }
  }

  getAumpur2() async {
    try {
      var jsonData = await RestAPI().postMethod(
          ApiPath().masterAmphur,
          {
            // "trans_id": "11111111",
            "state_id": provinceId2
          },
          isxxxxxx: false);

      amphurModel = MasterAmphurModel.fromJson(jsonData);

      amphurModel!.result!.detailDistrict!.forEach((element) {
        aumpurList2.add(element.cityName!);
      });
      notifyListeners();
    } catch (e) {
      print('errormasterAumphur = $e');
    }
  }

  getTumbol2() async {
    try {
      var jsonData = await RestAPI().postMethod(
          ApiPath().masterTumbol,
          {
            // "trans_id": "11111111",
            // "id": 0,
            "city_id": aumpurId2,
            "state_id": provinceId2,
          },
          isxxxxxx: false);

      tumbolModel = MasterTumbolModel.fromJson(jsonData);
      tumbolModel!.result!.detailSubDistrict!.forEach((element) {
        tumbolList2.add(element.areaName!);
      });
      notifyListeners();
    } catch (e) {
      print('errormasterTambol = $e');
    }
  }

  getPreference() async {
    addrsNumbCtrl.text = PreferenceUtils.getNtAddressNumb() ?? '';
    mooBanCtrl.text = PreferenceUtils.getNtMooban() ?? '';
    postOffCtrl.text = PreferenceUtils.getNtPostOff() ?? '';
    addrsNumbCtrl2.text = PreferenceUtils.getNtAddressNumb2() ?? '';
    mooBanCtrl2.text = PreferenceUtils.getNtMooban2() ?? '';
    postOffCtrl2.text = PreferenceUtils.getNtPostOff2() ?? '';
    selectAddressSameSts = PreferenceUtils.getNtSelectAddressSame() ?? false;

    await getPATfromPreferent();

    if (selectAddressSameSts) {
      isSelectAddressSame(selectAddressSameSts);
    } else {
      getPAT2fromPreferent();
    }

    if (PreferenceUtils.getNtAreapicker() != null &&
        PreferenceUtils.getNtAreapicker().toString().trim() != '') {
      List<String> _areapickerList =
          PreferenceUtils.getNtAreapicker()!.split(',');

      _areapickerList.forEach((value) {
        provinceModel!.result!.detailProvince!.forEach((element) {
          if (element.id.toString() == value) element.status = '1';
        });
      });
    }

    if (PreferenceUtils.getNtPackageBuy() != null &&
        PreferenceUtils.getNtPackageBuy().toString().trim() != '') {
      List<String> _packatebuyList =
          PreferenceUtils.getNtPackageBuy()!.split(',');

      _packatebuyList.forEach((value) {
        equipmentModel!.response!.detailEquipment!.forEach((element) {
          if (element.itemId == value) element.itemStatus = 'True';
        });
      });
    }
  }

  Future getPATfromPreferent() async {
    provinceText = PreferenceUtils.getNtProvince() ?? '';
    if (provinceText.trim().isNotEmpty && provinceText.trim() != '')
      await selectProvide(provinceText);

    aumpurText = PreferenceUtils.getNtAumpur() ?? '';
    if (aumpurText.trim().isNotEmpty && aumpurText.trim() != '')
      await selectAumpur(aumpurText);

    tumbolText = PreferenceUtils.getNtTumbol() ?? '';
    if (tumbolText.trim().isNotEmpty && tumbolText.trim() != '')
      await selectTumbol(tumbolText);
  }

  Future getPAT2fromPreferent() async {
    provinceText2 = PreferenceUtils.getNtProvince2() ?? '';
    if (provinceText2.trim().isNotEmpty && provinceText2.trim() != '')
      await selectProvide2(provinceText2);

    aumpurText2 = PreferenceUtils.getNtAumpur2() ?? '';
    if (aumpurText2.trim().isNotEmpty && aumpurText2.trim() != '')
      await selectAumpur2(aumpurText2);

    tumbolText2 = PreferenceUtils.getNtTumbol2() ?? '';
    if (tumbolText2.trim().isNotEmpty && tumbolText2.trim() != '')
      await selectTumbol2(tumbolText2);
  }

  setPreference() {
    PreferenceUtils.setNtAddressNumb(addrsNumbCtrl.text);
    PreferenceUtils.setNtMooban(mooBanCtrl.text);
    PreferenceUtils.setNtProvince(provinceText);
    PreferenceUtils.setNtAumpur(aumpurText);
    PreferenceUtils.setNtTumbol(tumbolText);
    PreferenceUtils.setNtPostOff(postOffCtrl.text);
    PreferenceUtils.setNtSelectAddressSame(selectAddressSameSts);
    PreferenceUtils.setNtAddressNumb2(addrsNumbCtrl2.text);
    PreferenceUtils.setNtMooban2(mooBanCtrl2.text);
    PreferenceUtils.setNtProvince2(provinceText2);
    PreferenceUtils.setNtAumpur2(aumpurText2);
    PreferenceUtils.setNtTumbol2(tumbolText2);
    PreferenceUtils.setNtPostOff2(postOffCtrl2.text);
    PreferenceUtils.setNtProvinceID(provinceId!);
    PreferenceUtils.setNtAumpurID(aumpurId!);
    PreferenceUtils.setNtTumbolID(tumbolID!);
    PreferenceUtils.setNtProvinceID2(provinceId2!);
    PreferenceUtils.setNtAumpurID2(aumpurId2!);
    PreferenceUtils.setNtTumbolID2(tumbolID2!);

    String _provinceData = '';
    String _equipmentData = '';

    provinceModel!.result!.detailProvince!.forEach(
      (element) {
        if (element.status == '1') {
          _provinceData += ',${element.id}';
        }
      },
    );

    List<DetailEquipment> _equipment = equipmentModel!
        .response!.detailEquipment!
        .where((element) => element.itemStatus == 'True')
        .toList();
    _equipment.forEach((element) {
      _equipmentData += ',${element.itemId}';
    });

    PreferenceUtils.setNtAreapicker(
        _provinceData == '' ? _provinceData : _provinceData.substring(1));
    PreferenceUtils.setNtPackageBuy(
        _equipmentData == '' ? _equipmentData : _equipmentData.substring(1));
  }

  changeStsSelect(bool sts, int index, String flag) {
    if (flag == 'package') {
      sts
          ? equipmentModel!.response!.detailEquipment![index].itemStatus =
              'True'
          : equipmentModel!.response!.detailEquipment![index].itemStatus =
              'False';
    } else if (flag == 'province') {
      sts
          ? provinceModel!.result!.detailProvince![index].status = "1"
          : provinceModel!.result!.detailProvince![index].status = "0";
    }

    notifyListeners();
  }

  checkSelectDropDown(String flagPage, String value) {
    if (flagPage == 'Provide') {
      selectProvide(value);
    } else if (flagPage == 'Aumpur') {
      selectAumpur(value);
    } else if (flagPage == 'Tumbol')
      selectTumbol(value);
    else if (flagPage == 'Provide2') {
      selectProvide2(value);
    } else if (flagPage == 'Aumpur2') {
      selectAumpur2(value);
    } else if (flagPage == 'Tumbol2') selectTumbol2(value);
  }

  selectProvide(String text) async {
    DetailProvince _data = provinceModel!.result!.detailProvince!
        .firstWhere((element) => element.stateName == text);
    provinceId = _data.id;
    provinceText = text;
    provinceSts = true;
    aumpurText = " ";
    tumbolText = " ";
    aumpurList = [];
    tumbolList = [];

    await getAumpur();
    stsAumpurEnable = true;
    stsTumbolEnable = false;

    notifyListeners();
  }

  selectAumpur(String text) async {
    DetailDistrict _data = amphurModel!.result!.detailDistrict!
        .firstWhere((element) => element.cityName == text);
    aumpurId = _data.id;
    aumpurText = text;
    aumpurSts = true;
    tumbolText = "";
    tumbolList = [];

    await getTumbol();
    stsTumbolEnable = true;

    notifyListeners();
  }

  selectTumbol(String text) {
    DetailSubDistrict _data = tumbolModel!.result!.detailSubDistrict!
        .firstWhere((element) => element.areaName == text);
    tumbolID = _data.id;
    tumbolText = text;
    tumbolSts = true;
    notifyListeners();
  }

  selectProvide2(String text) async {
    DetailProvince _data = provinceModel!.result!.detailProvince!
        .firstWhere((element) => element.stateName == text);
    provinceId2 = _data.id;
    provinceText2 = text;
    provinceSts2 = true;
    aumpurText2 = " ";
    tumbolText2 = " ";
    aumpurList2 = [];
    tumbolList2 = [];

    await getAumpur2();
    stsAumpurEnable2 = true;
    stsTumbolEnable2 = false;

    notifyListeners();
  }

  selectAumpur2(String text) async {
    DetailDistrict _data = amphurModel!.result!.detailDistrict!
        .firstWhere((element) => element.cityName == text);
    aumpurId2 = _data.id;
    aumpurText2 = text;
    aumpurSts2 = true;
    tumbolText2 = "";
    tumbolList2 = [];

    await getTumbol2();
    stsTumbolEnable2 = true;

    notifyListeners();
  }

  selectTumbol2(String text) {
    DetailSubDistrict _data = tumbolModel!.result!.detailSubDistrict!
        .firstWhere((element) => element.areaName == text);
    tumbolID2 = _data.id;
    tumbolText2 = text;
    tumbolSts2 = true;
    notifyListeners();
  }

  textOnchage(String flage) {
    switch (flage) {
      case 'addrsNumb':
        addrsNumbSts = true;
        break;
      case 'mooBan':
        mooBanSts = true;
        break;
      case 'postOff':
        postOffSts = true;
        break;
      case 'addrsNumb2':
        addrsNumbSts2 = true;
        break;
      case 'mooBan2':
        mooBanSts2 = true;
        break;
      case 'postOff2':
        postOffSts2 = true;
        break;

      default:
    }
    notifyListeners();
  }

  isSelectAddressSame(bool sts) {
    selectAddressSameSts = sts;
    if (selectAddressSameSts) {
      addrsNumbCtrl2.text = addrsNumbCtrl.text;
      mooBanCtrl2.text = mooBanCtrl.text;
      provinceText2 = provinceText;
      aumpurText2 = aumpurText;
      tumbolText2 = tumbolText;
      postOffCtrl2.text = postOffCtrl.text;
      aumpurList2 = aumpurList;
      tumbolList2 = tumbolList;
      stsAddrsNumb2Enable = false;
      stsMooBan2Enable = false;
      stsPostOffSts2Enable = false;
      stsProvinceSts2Enable = false;
      stsAumpurEnable2 = false;
      stsTumbolEnable2 = false;
      provinceId2 = provinceId;
      aumpurId2 = aumpurId;
      tumbolID2 = tumbolID;
    } else {
      addrsNumbCtrl2.text = "";
      mooBanCtrl2.text = "";
      provinceText2 = "";
      aumpurText2 = "";
      tumbolText2 = "";
      postOffCtrl2.text = "";
      aumpurList2 = [];
      tumbolList2 = [];
      stsAddrsNumb2Enable = true;
      stsMooBan2Enable = true;
      stsPostOffSts2Enable = true;
      stsProvinceSts2Enable = true;
      stsAumpurEnable2 = false;
      stsTumbolEnable2 = false;
      provinceId2 = 0;
      aumpurId2 = 0;
      tumbolID2 = 0;
    }

    notifyListeners();
  }

  bool checkAreaPicker() {
    int count = 0;
    provinceModel!.result!.detailProvince!.forEach((element) {
      if (element.status == '1') {
        count++;
      }
    });
    return count == 0 ? true : false;
  }

  actionSubmit(BuildContext context, String flag) {
    if (flag == 'save') {
      setPreference();
      normalDialog(context, 'บันทึกสำเร็จ');
    } else {
      if (addrsNumbCtrl.text.trim().isEmpty) {
        addrsNumbSts = false;
      } else if (mooBanCtrl.text.trim().isEmpty) {
        mooBanSts = false;
      } else if (provinceText.trim().isEmpty) {
        provinceSts = false;
      } else if (aumpurText.trim().isEmpty) {
        aumpurSts = false;
      } else if (tumbolText.trim().isEmpty) {
        tumbolSts = false;
      } else if (postOffCtrl.text.trim().isEmpty ||
          postOffCtrl.text.trim().length < 5) {
        postOffSts = false;
      } else if (addrsNumbCtrl2.text.trim().isEmpty) {
        addrsNumbSts2 = false;
      } else if (mooBanCtrl2.text.trim().isEmpty) {
        mooBanSts2 = false;
      } else if (provinceText2.trim().isEmpty) {
        provinceSts2 = false;
      } else if (aumpurText2.trim().isEmpty) {
        aumpurSts2 = false;
      } else if (tumbolText2.trim().isEmpty) {
        tumbolSts2 = false;
      } else if (postOffCtrl2.text.trim().isEmpty ||
          postOffCtrl2.text.trim().length < 5) {
        postOffSts2 = false;
      } else if (checkAreaPicker()) {
        normalDialog(context, 'กรุณาเลือกจังหวัดใกล้เคียง');
      } else {
        setPreference();
        Navigator.pushNamed(context, '/registerStep3');
      }
      notifyListeners();
    }
  }
}
