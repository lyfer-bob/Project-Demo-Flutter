import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:project_test/blocs/nation/RigisterStep3_provider.dart';

import 'package:provider/provider.dart';
import 'components/Constants.dart';

class RegisterStep3Page extends StatefulWidget {
  @override
  _RegisterStep3Page createState() => _RegisterStep3Page();
}

class _RegisterStep3Page extends State<RegisterStep3Page> {
  var constants = Constants();

  @override
  void initState() {
    Provider.of<RigisterStep3Provider>(context, listen: false).intit();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: leadingAppbar(context),
          title: titleAppbar(),
          flexibleSpace: flexibleSpace()),
      body: Consumer<RigisterStep3Provider>(
        builder: (context, pvd, child) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 15, right: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header('บัญชีธนาคาร'),
                typeHeader('ธนาคาร'),
                dropDownLists(
                  listsData: pvd.bankList,
                  enable: true,
                  stsChange: pvd.bankSts,
                  value: pvd.bankText,
                  flagPage: 'bank',
                  textValid: 'กรุณาเลือกธนาคาร',
                ),
                typeHeader('หมายเลขบัญชี'),
                textField(
                  controller: pvd.accoutNumBerContrl,
                  stsChange: pvd.accoutNumbSts,
                  flagPage: 'accoutNumb',
                  textValid: 'กรุณากรอกหมายเลขบัญชี ',
                  textInputType: TextInputType.phone,
                ),
                typeHeader('ชื่อบัญชี'),
                textField(
                  controller: pvd.accoutNameContrl,
                  stsChange: pvd.accoutNameSts,
                  flagPage: 'accoutName',
                  textValid: 'กรุณากรอกชื่อบัญชี ',
                ),
                typeHeader('หน้าสมุดบัญชี'),
                textFieldSelectFile(
                  enabled: false,
                  selectFile: true,
                  stsChange: pvd.accoutPicSts,
                  controller: pvd.accoutPicContrl,
                  flagPage: 'accoutPic',
                  textValid: 'กรุณาเลือกหน้าสมุดบัญชี',
                ),
                descriptionFile(),
                divider(),
                header('ทะเบียนรถ'),
                typeHeader('ยี่ห้อ'),
                textField(
                  controller: pvd.brandContrl,
                  stsChange: pvd.brandSts,
                  flagPage: 'brand',
                  textValid: 'กรุณากรอกยี่ห้อ',
                ),
                typeHeader('รุ่น'),
                textField(
                  controller: pvd.modelContrl,
                  stsChange: pvd.modelSts,
                  flagPage: 'model',
                  textValid: 'กรุณากรอกรุ่น',
                ),
                typeHeader('ทะเบียน'),
                textField(
                  controller: pvd.registContrl,
                  stsChange: pvd.registSts,
                  flagPage: 'regist',
                  textValid: 'กรุณากรอกทะเบียน',
                ),
                typeHeader('จังหวัด'),
                dropDownLists(
                  listsData: pvd.provinceList,
                  enable: true,
                  stsChange: pvd.provinceSts,
                  value: pvd.provinceText,
                  flagPage: 'province',
                  textValid: 'กรุณาเลือกจังหวัด',
                ),
                typeHeader('เป็นเจ้าของรถเองหรือไม่'),
                radioButton(),
                typeHeader('บัตรประชาชนเจ้าของรถ'),
                textFieldSelectFile(
                  enabled: false,
                  selectFile: true,
                  stsChange: pvd.cardNumbPicSts,
                  controller: pvd.cardNumbPicContrl,
                  flagPage: 'cardNumbPic',
                  textValid: 'กรุณาเลือกรูปบัตรประชาชน',
                ),
                typeHeader('หนังสือยินยอมเจ้าของรถ'),
                textFieldSelectFile(
                  enabled: false,
                  selectFile: true,
                  stsChange: pvd.policySts,
                  controller: pvd.policyPicContrl,
                  flagPage: 'policyPic',
                  textValid: 'กรุณาเลือกรูปหนังสือยินยอม',
                ),
                textNote(),
                rowAcctionButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowAcctionButton(BuildContext context) {
    return Consumer<RigisterStep3Provider>(
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
                  fontSize: 20,
                  fontColor: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget textNote() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 15),
      child: Row(
        children: [
          Flexible(
            child: Column(
              children: [
                Text(
                    """*หมายเหตุ กรณีไม่ใช่รถของตนเอง ใช้สำเนาบัตรประชาชนเจ้าของ รถ (จำเป็นต้องใช้หนังสือยินยอมให้ใช้รถจากเจ้าของรถ โดยลงมือลายชื่อและระบุ "ยินยอมให้นาย/นาง/นางสาว...นำรถทะเบียน...ยี่ห้อ...รุ่น... เพื่อเข้าร่วมขับ...")""",
                    style: TextStyle(
                      fontFamily: 'Sarabun',
                      color: Color(0xff7a7a7a),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget radioButton() {
    return Consumer<RigisterStep3Provider>(
      builder: (context, pvd, child) => Row(
        children: [
          Radio(
            value: pvd.radio.first,
            groupValue: pvd.grouRadio,
            // activeColor: Color(0xFFFEBC18),
            onChanged: (int? value) => pvd.changeStatusSelect(value),
          ),
          Text('ใช่', style: textStyleData(fontSize: 13)),
          Radio(
            value: pvd.radio[1],
            groupValue: pvd.grouRadio,
            // activeColor: Color(0xFFFEBC18),
            onChanged: (int? value) => pvd.changeStatusSelect(value),
          ),
          Text('ไม่ใช่', style: textStyleData(fontSize: 13)),
        ],
      ),
    );
  }

  Padding descriptionFile() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text("(.jpeg, .png ขนาดไฟล์ไม่เกิน 3 MB)",
          style: TextStyle(
            fontFamily: 'Sarabun',
            color: Color(0xff7a7a7a),
            fontSize: 13,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          )),
    );
  }

  Widget textField({
    bool enabled = true,
    String textValid = '',
    String flagPage = '',
    bool stsChange = false,
    int? maxLength,
    TextEditingController? controller,
    TextInputType? textInputType,
  }) {
    return Consumer<RigisterStep3Provider>(
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
                  onSubmitted: (value) => pvd.textOnchage(flagPage),
                  cursorColor: Colors.black,
                  style: textStyleData(fontSize: 18),
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
                  fontSize: 12,
                  fontColor: Colors.red,
                  fontWeight: FontWeight.w200),
            ),
          )
        ],
      ),
    );
  }

  Widget textFieldSelectFile(
      {bool enabled = true,
      String textValid = '',
      String flagPage = '',
      bool stsChange = false,
      int? maxLength,
      TextEditingController? controller,
      TextInputType? textInputType,
      bool selectFile = false}) {
    return Consumer<RigisterStep3Provider>(
      builder: (context, pvd, child) => InkWell(
        onTap: () {
          if (selectFile) pvd.getFileAndNameImage(flagPage);
        },
        child: Column(
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
                    onSubmitted: (value) => pvd.textOnchage(flagPage),
                    cursorColor: Colors.black,
                    style: textStyleData(fontSize: 18),
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
                      suffixIcon: Visibility(
                        visible: selectFile,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            color: Color(0xFF3D525C),
                            height: 20,
                            width: 20,
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('เลือก',
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                    Text('ไฟล์ ',
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))),
            Visibility(
              visible: !stsChange,
              child: Text(
                ' $textValid',
                style: textStyleData(
                    fontSize: 12,
                    fontColor: Colors.red,
                    fontWeight: FontWeight.w200),
              ),
            )
          ],
        ),
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
    return Consumer<RigisterStep3Provider>(
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
                  fontSize: 12,
                  fontColor: Colors.red,
                  fontWeight: FontWeight.w200),
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
      {double? fontSize = 20, FontWeight? fontWeight, Color? fontColor}) {
    return TextStyle(
      fontFamily: 'THSarabun',
      fontSize: fontSize,
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

  Widget header(String text) {
    return Text(text,
        style: TextStyle(
          fontFamily: 'Sarabun',
          color: Color(0xff3d525c),
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
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
