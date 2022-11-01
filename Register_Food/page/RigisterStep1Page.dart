import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:project_test/blocs/nation/RigisterStep1_provider.dart';
import 'package:provider/provider.dart';
import 'components/Constants.dart';

class RegisterStep1Page extends StatefulWidget {
  @override
  _RegisterStep1Page createState() => _RegisterStep1Page();
}

class _RegisterStep1Page extends State<RegisterStep1Page> {
  var constants = Constants();

  String _dateText = '';
  DateTime? _dateValue;

  @override
  void initState() {
    Provider.of<RigisterStep1Provider>(context, listen: false).intit();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: leadingAppbar(context),
          title: titleAppbar(),
          flexibleSpace: flexibleSpace()),
      body: Consumer<RigisterStep1Provider>(
        builder: (context, pvd, child) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 15, right: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header('ข้อมูลส่วนตัว'),
                rowPicRider(),
                pictureAndDescription(context),
                typeHeader('ชื่อ'),
                rowName(),
                typeHeader('นามสกุล'),
                textField(
                  stsChange: pvd.surNameStsChange,
                  flagPage: 'surname',
                  controller: pvd.surNameContrl,
                  textValid: 'กรุณากรอกนามสกุล',
                ),
                typeHeader('เลขที่บัตรประชาชน'),
                textField(
                    textInputType: TextInputType.phone,
                    stsChange: pvd.cardNumbStsChange,
                    flagPage: 'cardNumb',
                    controller: pvd.cardNumbContrl,
                    textValid: 'กรุณากรอกเลขบัตรประชาชน',
                    maxLength: 13),
                rowTextCardNumber(),
                rowTextFieldCardnumber(),
                rowTextSexAndBirth(context),
                rowDropSexAndBirthTextField(),
                rowAgeTextAndIncom(context),
                rowAgeTextFieldAndIncom(pvd.ageContrl),
                typeHeader('เบอร์โทรศัพท์'),
                textField(
                  textInputType: TextInputType.phone,
                  stsChange: pvd.phoneStsChange,
                  flagPage: 'phone',
                  controller: pvd.phoneContrl,
                  textValid: 'กรุณากรอกเบอร์โทรศัพท์  ',
                  maxLength: 10,
                ),
                typeHeader('อีเมล', required: false),
                textField(
                  stsChange: pvd.emailStsChange,
                  flagPage: 'email',
                  controller: pvd.emailContrl,
                  textValid: pvd.textValidEmail,
                ),
                rowAcctionButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rowAgeTextFieldAndIncom(TextEditingController controller) {
    return Consumer<RigisterStep1Provider>(
      builder: (context, pvd, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              flex: 3,
              child: textField(enabled: false, controller: controller)),
          Flexible(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: dropDownLists(
                listsData: pvd.riderBill,
                value: pvd.riderBillText,
                flagPage: 'riderBill',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row rowAgeTextAndIncom(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(flex: 3, child: typeHeader('อายุ')),
        Flexible(
          flex: 7,
          child: Padding(
              padding: EdgeInsets.only(left: 7),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: typeHeader('รอบการเบิกรายได้'),
              )),
        )
      ],
    );
  }

  Widget rowDropSexAndBirthTextField() {
    return Consumer<RigisterStep1Provider>(
      builder: (context, pvd, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: dropDownLists(
              listsData: pvd.sex,
              value: pvd.sexText,
              flagPage: 'sex',
            ),
          ),
          Flexible(
            flex: 7,
            child: calendar(pvd.birthDateContrl, 'birthdate'),
          ),
        ],
      ),
    );
  }

  Row rowTextSexAndBirth(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(flex: 3, child: typeHeader('เพศ')),
        Flexible(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.only(left: 7),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: typeHeader('วันเกิด', required: false)),
            )),
      ],
    );
  }

  Widget calendar(TextEditingController controller, String flag) {
    return Consumer<RigisterStep1Provider>(
      builder: (context, pvd, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateTimePicker(
            type: DateTimePickerType.date,
            dateMask: ' dd/MM/yyyy',
            decoration: InputDecoration(
              hintStyle: Constants()
                  .textStyleRegular(colorValue: Colors.black, fontSize: 20),
              hintText: controller.text.isEmpty
                  ? null
                  : '   ${dateShow(controller.text)}',
              suffixIcon: Icon(Icons.calendar_today_rounded,
                  color: Color.fromARGB(255, 98, 98, 97)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 196, 196, 194),
                ),
              ),
            ),
            onChanged: (String? value) {
              pvd.onchangDate(value!, flag, context);
            },
            // textInputAction: TextInputAction.continueAction,
            initialDatePickerMode: DatePickerMode.day,
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            // inputFormatters: [
            //   FilteringTextInputFormatter.allow('filterPattern'),
            //   // EditableText()
            // ],
            style: Constants().textStyleRegular(fontSize: 20),
            firstDate: DateTime(1000),
            lastDate: DateTime(3000),
            fieldHintText: "DATE/MONTH/YEAR",
          ),
        ],
      ),
    );
  }

  String dateShow(String value) =>
      '${value.split('/')[0]}/${value.split('/')[1]}/${(int.parse(value.split('/').last) - 543).toString()}';

  Widget rowTextFieldCardnumber() {
    return Consumer<RigisterStep1Provider>(
      builder: (context, pvd, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(flex: 475, child: calendar(pvd.cardDateContrl, 'active')),
          Flexible(flex: 50, child: SizedBox()),
          Flexible(flex: 475, child: calendar(pvd.cardExpDateContrl, 'exp')),
        ],
      ),
    );
  }

  Row rowTextCardNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        typeHeader('วันออกบัตรประชาชน'),
        typeHeader('วันบัตรประชาชนหมดอายุ'),
      ],
    );
  }

  Widget rowName() {
    return Consumer<RigisterStep1Provider>(
      builder: (context, pvd, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: dropDownLists(
              listsData: pvd.titleName,
              value: pvd.titleText,
              flagPage: 'title',
            ),
          ),
          Flexible(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: SizedBox(
                  child: textField(
                stsChange: pvd.nameStsChange,
                flagPage: 'name',
                controller: pvd.nameContrl,
                textValid: 'กรุณากรอกชื่อ',
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget pictureAndDescription(BuildContext context) {
    return Consumer<RigisterStep1Provider>(
      builder: (context, pvd, child) => InkWell(
        onTap: () => pvd.selectImage(context),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: pvd.base64 == ''
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.width * 0.45,
                      child: Icon(
                        Icons.account_circle,
                        size: MediaQuery.of(context).size.width * 0.3,
                        color: Color(0xFF93d1ff),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black12,
                          width: 0.65,
                        ),
                      ))
                  : Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.6,
                      child: Image.memory(base64Decode(pvd.base64))),
            ),
            Text(
              "รูปถ่ายหน้าตรง ไม่สวมหมวก หรือ แว่นดำ และ",
              style: textStyleData(font: 14, fontColor: Colors.black),
            ),
            Text(
              "เป็นรูปสี ไม่เกิน 6 เดือน (รูปนี้จะปรากฎที่หน้าแอปฯ)",
              style: textStyleData(font: 14, fontColor: Colors.black),
            ),
            Text(
              " *ขนาดแนะนำ60x60 px (.jpeg, .png ขนาดไฟล์ไม่เกิน 3 MB)",
              style: textStyleData(font: 14, fontColor: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowPicRider() {
    return Consumer<RigisterStep1Provider>(
      builder: (context, pvd, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          typeHeader('รูปไรเดอร์'),
          InkWell(
            onTap: () => pvd.selectImage(context),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.create_sharp),
                ),
                Text(
                  "แก้ไข",
                  style: textStyleData(
                      fontWeight: FontWeight.bold,
                      font: 22,
                      fontColor: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rowAcctionButton(BuildContext context) {
    return Consumer<RigisterStep1Provider>(
      builder: (_, pvd, child) => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
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
      {bool cacalendarMode = false,
      bool enabled = true,
      String textValid = '',
      String flagPage = '',
      bool stsChange = false,
      int? maxLength,
      TextEditingController? controller,
      TextInputType? textInputType}) {
    return Consumer<RigisterStep1Provider>(
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
                    suffixIcon: Visibility(
                      visible: cacalendarMode,
                      child: Material(
                        borderRadius: BorderRadius.zero,
                        elevation: 0,
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: Color(0xFF3d525c),
                          size: 30,
                        ),
                      ),
                    ),
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
    bool stsChange = true,
  }) {
    return Consumer<RigisterStep1Provider>(
      builder: (context, pvd, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownSearch<String>(
            popupProps: PopupProps.menu(
              showSearchBox: true,
            ),
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
      onPressed: () =>
          Navigator.popUntil(context, ModalRoute.withName('/logIn')),
    );
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

  Widget typeHeader(String text, {bool required = true}) {
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
            text: required ? "*" : '',
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
}
