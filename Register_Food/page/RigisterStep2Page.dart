import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:project_test/blocs/nation/RigisterStep2_provider.dart';
import 'package:project_test/models/nation/MasterEquipmentModel.dart';
import 'package:project_test/models/nation/MasterProvinceModel.dart';

import 'package:provider/provider.dart';
import 'components/Constants.dart';

class RegisterStep2Page extends StatefulWidget {
  @override
  _RegisterStep2Page createState() => _RegisterStep2Page();
}

class _RegisterStep2Page extends State<RegisterStep2Page> {
  var constants = Constants();

  @override
  void initState() {
    Provider.of<RigisterStep2Provider>(context, listen: false).intit();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: leadingAppbar(context),
          title: titleAppbar(),
          flexibleSpace: flexibleSpace()),
      body: Consumer<RigisterStep2Provider>(
        builder: (context, pvd, child) => pvd.equipmentModel == null ||
                pvd.provinceModel == null
            ? Constants().progressAPI()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 15, right: 15, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header('ที่อยู่ปัจจุบัน'),
                      typeHeader('บ้านเลขที่/ที่อยู่'),
                      textField(
                        stsChange: pvd.addrsNumbSts,
                        flagPage: 'addrsNumb',
                        controller: pvd.addrsNumbCtrl,
                        textValid: 'กรุณากรอกบ้านเลขที่ ',
                      ),
                      typeHeader('ชื่อตึก/หมู่บ้าน'),
                      textField(
                        stsChange: pvd.mooBanSts,
                        flagPage: 'mooBan',
                        controller: pvd.mooBanCtrl,
                        textValid: 'กรุณากรอกชื่อตึก/หมู่บ้าน',
                      ),
                      typeHeader('จังหวัด'),
                      dropDownLists(
                        stsChange: pvd.provinceSts,
                        listsData: pvd.provinceList,
                        value: pvd.provinceText,
                        enable: true,
                        flagPage: 'Provide',
                        textValid: 'กรุณาเลือกจังหวัด',
                      ),
                      typeHeader('เขต/อำเภอ'),
                      dropDownLists(
                        stsChange: pvd.aumpurSts,
                        listsData: pvd.aumpurList,
                        value: pvd.aumpurText,
                        enable: pvd.stsAumpurEnable,
                        flagPage: 'Aumpur',
                        textValid: 'กรุณาเลือกเขต/อำเภอ',
                      ),
                      typeHeader('แขวง/ตำบล'),
                      dropDownLists(
                        stsChange: pvd.tumbolSts,
                        listsData: pvd.tumbolList,
                        value: pvd.tumbolText,
                        enable: pvd.stsTumbolEnable,
                        flagPage: 'Tumbol',
                        textValid: 'กรุณาเลือกแขวง/ตำบล',
                      ),
                      typeHeader('รหัสไปรษณีย์'),
                      textField(
                        maxLength: 5,
                        textInputType: TextInputType.phone,
                        stsChange: pvd.postOffSts,
                        flagPage: 'postOff',
                        controller: pvd.postOffCtrl,
                        textValid: 'กรุณากรอกรหัสไปรษณีย์ ',
                      ),
                      divider(),
                      addressByCardNumber(),
                      typeHeader('บ้านเลขที่/ที่อยู่'),
                      textField(
                        enabled: pvd.stsAddrsNumb2Enable,
                        stsChange: pvd.addrsNumbSts2,
                        flagPage: 'addrsNumb2',
                        controller: pvd.addrsNumbCtrl2,
                        textValid: 'กรุณากรอกบ้านเลขที่',
                      ),
                      typeHeader('ชื่อตึก/หมู่บ้าน'),
                      textField(
                        enabled: pvd.stsMooBan2Enable,
                        stsChange: pvd.mooBanSts2,
                        flagPage: 'mooBan2',
                        controller: pvd.mooBanCtrl2,
                        textValid: 'กรุณากรอกชื่อตึก/หมู่บ้าน',
                      ),
                      typeHeader('จังหวัด'),
                      dropDownLists(
                        stsChange: pvd.provinceSts2,
                        listsData: pvd.provinceList,
                        value: pvd.provinceText2,
                        enable: pvd.stsProvinceSts2Enable,
                        flagPage: 'Provide2',
                        textValid: 'กรุณาเลือกจังหวัด',
                      ),
                      typeHeader('เขต/อำเภอ'),
                      dropDownLists(
                        stsChange: pvd.aumpurSts2,
                        listsData: pvd.aumpurList2,
                        value: pvd.aumpurText2,
                        enable: pvd.stsAumpurEnable2,
                        flagPage: 'Aumpur2',
                        textValid: 'กรุณาเลือกเขต/อำเภอ',
                      ),
                      typeHeader('แขวง/ตำบล'),
                      dropDownLists(
                        stsChange: pvd.tumbolSts2,
                        listsData: pvd.tumbolList2,
                        value: pvd.tumbolText2,
                        enable: pvd.stsTumbolEnable2,
                        flagPage: 'Tumbol2',
                        textValid: 'กรุณาเลือกแขวง/ตำบล',
                      ),
                      typeHeader('รหัสไปรษณีย์'),
                      textField(
                        maxLength: 5,
                        enabled: pvd.stsPostOffSts2Enable,
                        textInputType: TextInputType.phone,
                        stsChange: pvd.postOffSts2,
                        flagPage: 'postOff2',
                        controller: pvd.postOffCtrl2,
                        textValid: 'กรุณากรอกรหัสไปรษณีย์ ',
                      ),
                      divider(),
                      header('พื้นที่จังหวัดที่ให้บริการบ่อย', required: true),
                      scrollBar(
                          flag: 'province',
                          listProvince:
                              pvd.provinceModel!.result!.detailProvince),
                      header('แพ็กเกจอุปกรณ์ที่ซื้อ'),
                      scrollBar(
                          flag: 'package',
                          listEquipment:
                              pvd.equipmentModel!.response!.detailEquipment),
                      rowAcctionButton(context)
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget addressByCardNumber() {
    return Consumer<RigisterStep2Provider>(
      builder: (context, pvd, child) => FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            header('ที่อยู่ตามบัตรประชาชน'),
            Row(
              children: [
                Checkbox(
                    value: pvd.selectAddressSameSts,
                    onChanged: (bool? sts) => pvd.isSelectAddressSame(sts!)),
                Text(
                  "ที่อยู่เดียวกับที่อยู่ปัจจุบัน",
                  style: textStyleData(font: 20, fontColor: Color(0xFF3d525c)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget scrollBar({
    List<DetailProvince>? listProvince,
    List<DetailEquipment>? listEquipment,
    required String flag,
  }) {
    return Consumer<RigisterStep2Provider>(
        builder: (context, pvd, child) => Padding(
              padding: const EdgeInsets.only(top: 17.0, bottom: 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black12,
                        width: 0.65,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: (lenghtDataDropDownList(
                                flag: flag,
                                listEquipment: listEquipment,
                                listProvince: listProvince) >=
                            6
                        ? 300
                        : 150),
                    child: Scrollbar(
                      thickness: 10,
                      child: ListView.builder(
                        itemCount: lenghtDataDropDownList(
                            flag: flag,
                            listEquipment: listEquipment,
                            listProvince: listProvince),
                        itemBuilder: (context, index) => Row(
                          children: [
                            Checkbox(
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                value: flag == 'province'
                                    ? listProvince![index].status == "1"
                                    : listEquipment![index].itemStatus ==
                                        "True",
                                onChanged: (bool? sts) =>
                                    pvd.changeStsSelect(sts!, index, flag)),
                            Text(
                              flag == 'province'
                                  ? listProvince![index].stateName.toString()
                                  : listEquipment![index].itemName.toString(),
                              style: textStyleData(
                                  fontWeight: FontWeight.bold,
                                  font: 20,
                                  fontColor: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  int lenghtDataDropDownList({
    List<DetailProvince>? listProvince,
    List<DetailEquipment>? listEquipment,
    required String flag,
  }) {
    if (flag == 'province')
      return listProvince!.length;
    else
      return listEquipment!.length;
  }

  Widget rowAcctionButton(BuildContext context) {
    return Consumer<RigisterStep2Provider>(
      builder: (_, pvd, child) => Row(
        children: [
          acctionButton(
            text: 'ย้อนกลับ',
            color: Color(0xffc0c0c0),
            onPressed: () => Navigator.pop(context),
          ),
          acctionButton(
            text: 'บันทึก',
            color: Color(0xff3d525c),
            onPressed: () => pvd.actionSubmit(context, 'save'),
          ),
          acctionButton(
            text: 'ถัดไป',
            color: Color(0xfffebc18),
            onPressed: () => pvd.actionSubmit(context, 'submit'),
          ),
        ],
      ),
    );
  }

  Widget acctionButton(
      {@required Color? color, @required onPressed, required String text}) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: color ?? Color(0xFF5ABF6F))),
        width: MediaQuery.of(context).size.width * 0.275,
        height: 50,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(0),
            backgroundColor: color ?? Color(0xFF5ABF6F),
            visualDensity: VisualDensity(horizontal: 1),
          ),
          autofocus: true,
          clipBehavior: Clip.none,
          onPressed: onPressed,
          child: FittedBox(
            child: Text(
              text,
              style: textStyleData(
                  fontWeight: FontWeight.w400,
                  font: 20,
                  fontColor: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(
      {bool enabled = true,
      String textValid = '',
      String flagPage = '',
      bool stsChange = false,
      int? maxLength,
      TextEditingController? controller,
      TextInputType? textInputType}) {
    return Consumer<RigisterStep2Provider>(
      builder: (context, pvd, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 47,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: enabled ? null : Color(0xFFeeeeee),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color(0xFFc0c0c0),
                  width: 0.45,
                ),
              ),
              child: TextField(
                  controller: controller ?? null,
                  keyboardType: textInputType ?? TextInputType.text,
                  cursorWidth: 1,
                  onChanged: ((value) => pvd.textOnchage(flagPage)),
                  // onSubmitted: (value) => pvd.textOnchage(flagPage),
                  cursorColor: Colors.black,
                  style: textStyleData(font: 18),
                  maxLines: 1,
                  enabled: enabled,
                  maxLength: maxLength ?? null,
                  decoration: InputDecoration(
                    counterStyle: TextStyle(
                      height: double.minPositive,
                    ),
                    counterText: "",
                    contentPadding: EdgeInsets.only(
                        top: 12.5, bottom: 12.5, left: 12, right: 12),
                    border: InputBorder.none,
                    focusedBorder: stsChange
                        ? InputBorder.none
                        : OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1)),
                    enabledBorder: stsChange
                        ? InputBorder.none
                        : OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1)),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ))),
          Visibility(
            visible: !stsChange,
            child: Text(
              ' $textValid',
              style: textStyleData(
                  font: 12, fontColor: Colors.red, fontWeight: FontWeight.w200),
            ),
          )
        ],
      ),
    );
  }

  Widget dropDownLists({
    required List<String> listsData,
    String flagPage = '',
    String? value,
    bool stsChange = false,
    bool enable = false,
    String textValid = '',
  }) {
    return Consumer<RigisterStep2Provider>(
      builder: (context, pvd, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownSearch<String>(
            popupProps: PopupProps.menu(
              showSearchBox: true,
            ),
            enabled: enable,
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: textStyleData(),
              dropdownSearchDecoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                focusedBorder: stsChange
                    ? OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFc0c0c0)))
                    : OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1)),
                enabledBorder: stsChange
                    ? OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFc0c0c0)))
                    : OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFc0c0c0))),
                counterStyle: textStyleData(),
              ),
            ),
            items: listsData,
            onChanged: (String? value) =>
                pvd.checkSelectDropDown(flagPage, value!),
            selectedItem: value,
          ),
          Visibility(
            visible: !stsChange,
            child: Text(
              ' $textValid',
              style: textStyleData(
                  font: 12, fontColor: Colors.red, fontWeight: FontWeight.w200),
            ),
          )
        ],
      ),
    );
  }

  TextStyle textStyleHint({double? font = 20}) {
    return TextStyle(
        fontFamily: 'THSarabun',
        fontSize: font,
        color: Color(0xff737373),
        fontWeight: FontWeight.normal);
  }

  TextStyle textStyleData(
      {double? font = 20, FontWeight? fontWeight, Color? fontColor}) {
    return TextStyle(
      fontFamily: 'THSarabun',
      fontSize: font,
      color: fontColor ?? Colors.black87,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  IconButton leadingAppbar(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back, color: Color(0xff3d525c)),
        onPressed: () => Navigator.of(context).pop());
  }

  Text titleAppbar() {
    return Text("ลงทะเบียนคนขับ",
        style: TextStyle(
          fontFamily: 'Sarabun',
          color: Color(0xff3d525c),
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ));
  }

  Container flexibleSpace() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.0, -1.0),
          end: Alignment(0.0, 1.0),
          colors: [
            Colors.white,
            Colors.white,
          ],
          stops: [0.0, 1.0],
        ),
      ),
    );
  }

  Widget header(String text, {bool required = false}) {
    return RichText(
        text: TextSpan(
      children: [
        TextSpan(
            text: text,
            style: TextStyle(
              fontFamily: 'Sarabun',
              color: Color(0xff3d525c),
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            )),
        TextSpan(
            text: required ? "*" : "",
            style: TextStyle(
              fontFamily: 'Sarabun',
              color: Color(0xffee0000),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            )),
      ],
    ));
  }

  Widget typeHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: text,
            style: TextStyle(
              fontFamily: 'Sarabun',
              color: Color(0xff3d525c),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            )),
        TextSpan(
            text: "*",
            style: TextStyle(
              fontFamily: 'Sarabun',
              color: Color(0xffee0000),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            )),
      ])),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, top: 25),
      child: Divider(
        color: Color(0xffc0c0c0),
        thickness: 1,
      ),
    );
  }
}
