import 'package:flutter/material.dart';
import 'package:project_test/blocs/nation/RigisterStep4_provider.dart';
import 'package:provider/provider.dart';
import 'components/Constants.dart';

class RegisterStep4Page extends StatefulWidget {
  @override
  State<RegisterStep4Page> createState() => _RegisterStep4Page();
}

class _RegisterStep4Page extends State<RegisterStep4Page> {
  @override
  void initState() {
    Provider.of<RigisterStep4Provider>(context, listen: false).intit();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: leadingAppbar(context),
          title: titleAppbar(),
          flexibleSpace: flexibleSpace()),
      body: Consumer<RigisterStep4Provider>(
        builder: (context, pvd, child) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: 10.0,
                left: MediaQuery.of(context).size.width * 0.035,
                right: MediaQuery.of(context).size.width * 0.035,
                bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                header('เอกสาร'),
                typeHeader('บัตรประชาชน'),
                textFieldSelectFile(
                  enabled: false,
                  selectFile: true,
                  stsChange: pvd.cardNumbSts,
                  controller: pvd.cardNumbCtrl,
                  flagPage: 'cardNumbPic',
                  textValid: 'กรุณาเลือกรูปบัตรประชาชน',
                ),
                typeHeader('เล่มรถ หรือ สำเนารถ'),
                textFieldSelectFile(
                  enabled: false,
                  selectFile: true,
                  stsChange: pvd.cardCarSts,
                  controller: pvd.cardCarCtrl,
                  flagPage: 'cardCarPic',
                  textValid: 'กรุณาเลือกรูปเล่มรถหรือสำเนารถ',
                ),
                typeHeader('ใบขับขี่'),
                textFieldSelectFile(
                  enabled: false,
                  selectFile: true,
                  stsChange: pvd.cardDriveSts,
                  controller: pvd.cardDriveCtrl,
                  flagPage: 'cardDrivePic',
                  textValid: 'กรุณาเลือกรูปใบขับขี่',
                ),
                typeHeader('ทะเบียนบ้าน'),
                textFieldSelectFile(
                  enabled: false,
                  selectFile: true,
                  stsChange: pvd.registHomeSts,
                  controller: pvd.registHomeCtrl,
                  flagPage: 'registHomePic',
                  textValid: 'กรุณาเลือกรูปทะเบียนบ้าน',
                ),
                descriptionFile(),
                divider(),
                header('ผู้ติดต่อกรณีฉุกเฉิน'),
                typeHeader('ชื่อ'),
                textField(
                  controller: pvd.nameCtrl,
                  stsChange: pvd.nameSts,
                  flagPage: 'name',
                  textValid: 'กรุณากรอกชื่อ',
                ),
                typeHeader('นามสกุล'),
                textField(
                  controller: pvd.surNameCtrl,
                  stsChange: pvd.surNameSts,
                  flagPage: 'surName',
                  textValid: 'กรุณากรอกนามสกุล',
                ),
                typeHeader('เบอร์โทรศัพท์'),
                textField(
                  maxLength: 10,
                  textInputType: TextInputType.numberWithOptions(),
                  controller: pvd.phoneCtrl,
                  stsChange: pvd.phoneSts,
                  flagPage: 'phone',
                  textValid: 'กรุณากรอกนามสกุล',
                ),
                typeHeader('ความสัมพันธ์'),
                textField(
                  controller: pvd.realatCtrl,
                  stsChange: pvd.realatSts,
                  flagPage: 'realat',
                  textValid: 'กรุณากรอกนามสกุล',
                ),
                divider(),
                header('การแสดงความยินยอม'),
                consent(),
                confirmBody(context),
                condition(),
                offer(),
                rowAcctionButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget confirmBody(BuildContext context) {
    return Consumer<RigisterStep4Provider>(
      builder: (_, pvd, child) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Flexible(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text.rich(
                        TextSpan(
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'THSarabun'),
                          children: [
                            TextSpan(
                                text: 'การรับรองความบกพร่องทางร่างกาย (ถ้ามี)'),
                            TextSpan(
                                text:
                                    '\n*การระบุและยอมรับข้อมูลส่วนนี้ แสดงว่าข้าพเจ้าตกลงและ'),
                            TextSpan(
                                text:
                                    '\nยินยอมให้ xxxxxx รวบรวม ใช้และเปิดเผยข้อมูลข้างต้น เพื่อ'),
                            TextSpan(text: '\nจุดประสงค์ดังต่อไปนี้:'),
                            TextSpan(
                                text: '\n(a) เพื่อดำเนินการสมัครของข้าพเจ้า'),
                            TextSpan(
                                text: '\n(b) เพื่อการจัดการภายในของ xxxxxx'),
                            TextSpan(
                                text:
                                    '\n(c) เพื่อการติดต่อสื่อสารกับข้าพเจ้า และ'),
                            TextSpan(
                                text:
                                    '\n(d) สำหรับ xxxxxx เพื่อให้เป็นไปตามกฎหมายและกฎระเบียบข้อบังคับ'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Checkbox(
                    activeColor: Constants().textColor,
                    value: pvd.checkBoxBody,
                    onChanged: (value) {
                      pvd.setCheckBox(value!, 'body');
                    },
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'THSarabun',
                              color: Colors.black87),
                          children: [
                        TextSpan(
                          text:
                              "ข้าพเจ้าขอรับรองว่าข้าพเจ้าไม่มีความบกพร่องทางร่างกาย",
                        ),
                        TextSpan(
                            text: "*",
                            style: TextStyle(
                              color: Color(0xffff0000),
                            )),
                      ])),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Consumer<RigisterStep4Provider> consent() {
    return Consumer<RigisterStep4Provider>(
      builder: (context, pvd, child) => Column(
        children: <Widget>[
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: pvd.checkBoxConsent1,
                activeColor: Constants().textColor,
                onChanged: (value) {
                  pvd.setCheckBox(value!, 'consent1');
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 18, fontFamily: 'THSarabun'),
                    children: [
                      TextSpan(
                          text:
                              'ข้าพเจ้าขอรับรองว่าเอกสารที่นำมายื่นกับ xxxxxx'),
                      TextSpan(
                          text: ' เป็นความความจริงถูกต้องและครบถ้วนทุกประการ '),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: pvd.checkBoxConsent2,
                activeColor: Constants().textColor,
                onChanged: (value) {
                  pvd.setCheckBox(value!, 'consent2');
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 18, fontFamily: 'THSarabun'),
                    children: [
                      TextSpan(
                          text:
                              'ข้าพเจ้ายินยอมให้ xxxxxx หักค่าธรรมเนียม และ ค่าอุปกรณ์ ตามที่พาร์ทเนอร์เลือก เช่น ค่าลงทะเบียน และ ค่าอุปกรณ์ กระเป๋า เสื้อ'),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: pvd.checkBoxConsent3,
                activeColor: Constants().textColor,
                onChanged: (value) {
                  pvd.setCheckBox(value!, 'consent3');
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 18, fontFamily: 'THSarabun'),
                    children: [
                      TextSpan(
                          text:
                              'ข้าพเจ้าขอยืนยันว่า ทุกครั้งที่รับงานจาก xxxxxx ข้าพเจ้าเป็นผู้มีสุขภาพดี ไม่เป็นโรคติดต่อร้ายแรง ไม่มีอาการไอ จาม หรือ อาการโรคติดต่อขั้นพื้นฐานอื่นๆ และอุณหภูมิร่างกายต่ำกว่า 37.5 องศา ถ้าหากมีอาการข้างต้นข้าพเจ้าจะหยุดรับงาน และไปพบแพทย์'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget rowAcctionButton(BuildContext context) {
    return Consumer<RigisterStep4Provider>(
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
            text: 'ส่งข้อมูล',
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

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, top: 25),
      child: Divider(
        color: Color(0xffc0c0c0),
        thickness: 1,
      ),
    );
  }

  Padding descriptionFile() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
          "บัตรประชาชนและใบขับขี่ บัตรอยู่ในสภาพสมบูรณ์ไม่หมดอายุ, (.jpeg, .png ขนาดไฟล์ไม่เกิน 3 MB)",
          style: TextStyle(
            fontFamily: 'Sarabun',
            color: Color(0xff7a7a7a),
            fontSize: 13,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          )),
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
    return Consumer<RigisterStep4Provider>(
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
                    // onChanged: ((value) => pvd.textOnchage(flagPage)),
                    // onSubmitted: (value) => pvd.textOnchage(flagPage),
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

  Widget textField({
    bool enabled = true,
    String textValid = '',
    String flagPage = '',
    bool stsChange = false,
    int? maxLength,
    TextEditingController? controller,
    TextInputType? textInputType,
  }) {
    return Consumer<RigisterStep4Provider>(
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

  Consumer offer() {
    return Consumer<RigisterStep4Provider>(
      builder: (context, pvd, child) => Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Constants().fontStyleBold('ข้อเสนอจาก xxxxxx'),
                Constants().fontStyleBold('*', colorValue: Colors.red),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                activeColor: Constants().textColor,
                value: pvd.checkBoxTitle,
                onChanged: (value) {
                  pvd.setCheckBox(value!, 'title');
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Constants().textAutoNewLine(
                  'ฉันต้องการรับข่าวสารกิจกรรม โปรโมชันต่างๆ ทาง',
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Row(
              children: <Widget>[
                Checkbox(
                  activeColor: Constants().textColor,
                  value: pvd.checkBoxCall,
                  onChanged: (value) {
                    if (pvd.checkBoxTitle) {
                      pvd.setCheckBox(value!, 'call');
                    }
                  },
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => BorderSide(
                        width: 2.0,
                        color: pvd.checkBoxTitle
                            ? Constants().textColor
                            : Colors.grey),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Constants().fontStyleRegular(
                    'การโทร',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Row(
              children: <Widget>[
                Checkbox(
                  activeColor: Constants().textColor,
                  value: pvd.checkBoxEmail,
                  onChanged: (value) {
                    if (pvd.checkBoxTitle) {
                      pvd.setCheckBox(value!, 'email');
                    }
                  },
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => BorderSide(
                        width: 2.0,
                        color: pvd.checkBoxTitle
                            ? Constants().textColor
                            : Colors.grey),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Constants().fontStyleRegular(
                    'อีเมล',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Row(
              children: <Widget>[
                Checkbox(
                  activeColor: Constants().textColor,
                  value: pvd.checkBoxNoti,
                  onChanged: (value) {
                    if (pvd.checkBoxTitle) {
                      pvd.setCheckBox(value!, 'noti');
                    }
                  },
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => BorderSide(
                        width: 2.0,
                        color: pvd.checkBoxTitle
                            ? Constants().textColor
                            : Colors.grey),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Constants().fontStyleRegular(
                    'การแจ้งเตือน',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Row(
              children: <Widget>[
                Checkbox(
                  activeColor: Constants().textColor,
                  value: pvd.checkBoxNoMessage,
                  onChanged: (value) {
                    pvd.setCheckBox(value!, 'noMessage');
                  },
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => BorderSide(
                        width: 2.0,
                        color: pvd.checkBoxTitle
                            ? Constants().textColor
                            : Colors.grey),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Constants().fontStyleRegular(
                    'ไม่รับข่าวสาร',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
          //   width: MediaQuery.of(context).size.width * 0.7,
          //   child: Constants().textAutoNewLine(
          //     'ฉันต้องการรับข้อมูลเกี่ยวกับช่องทางการสร้างรายได้',
          //     fontSize: 18,
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            child: Constants().fontStyleBold('โอกาสสร้างรายได้เพิ่มเติม'),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                activeColor: Constants().textColor,
                value: pvd.checkBoxOther,
                onChanged: (value) {
                  pvd.setCheckBox(value!, 'other');
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Constants().textAutoNewLine(
                  'ฉันต้องการรับข้อมูลเกี่ยวกับช่องทางการสร้างรายได้',
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Consumer condition() {
    return Consumer<RigisterStep4Provider>(
      builder: (context, pvd, child) => Column(
        children: <Widget>[
          FittedBox(
            child: Row(
              children: <Widget>[
                Constants().fontStyleBold('ข้อกำหนดเงื่อนไขและการรับข่าวสาร'),
                Constants().fontStyleBold('*', colorValue: Colors.red),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: pvd.checkBoxCondition1,
                activeColor: Constants().textColor,
                onChanged: (value) {
                  pvd.setCheckBox(value!, 'Condition1');
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 18, fontFamily: 'THSarabun'),
                    children: [
                      TextSpan(
                          text:
                              'ข้าพเจ้าตกลงและยินยอมให้ “บริษัท ฟู้ด ออเดอรี่ จำกัด” เก็บรวบรวม ใช้และเปิดเผยข้อมูลที่ข้าพเจ้าให้ไว้ในระหว่างการสมัครเพื่อดำเนินการตามที่จำเป็นภายใต้ '),
                      TextSpan(
                        text: '“นโยบายคุ้มครองข้อมูลส่วนบุคคล”',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ' ที่ข้าพเจ้าได้อ่านและเข้าใจ'),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: pvd.checkBoxCondition2,
                activeColor: Constants().textColor,
                onChanged: (value) {
                  pvd.setCheckBox(value!, 'Condition2');
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 18, fontFamily: 'THSarabun'),
                    children: [
                      TextSpan(text: 'ข้าพเจ้ายอมรับ '),
                      TextSpan(
                        text: '“ข้อกำหนดและเงื่อนไข”',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                          text:
                              ' ของ “บริษัท ฟู้ด ออเดอรี่ จำกัด” หากข้าพเจ้าผิดข้อกำหนดและเงื่อนไขหรือข้อตกลงเพิ่มเติมใด ข้าพเจ้าตกลงและยอมรับว่า “บริษัท ฟู้ด ออเดอรี่ จำกัด” มีสิทธิดำเนินการใด ๆ ตามที่บริษัทเห็นสมควร'),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                value: pvd.checkBoxCondition3,
                activeColor: Constants().textColor,
                onChanged: (value) {
                  pvd.setCheckBox(value!, 'Condition3');
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 18, fontFamily: 'THSarabun'),
                    children: [
                      TextSpan(
                          text:
                              'ข้าพเจ้ายินยอมให้ “บริษัท ฟู้ด ออเดอรี่ จำกัด”'),
                      TextSpan(text: 'ตรวจสอบประวัติอาชญากรรม '),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
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

  TextStyle textStyleData(
      {double? fontSize = 20, FontWeight? fontWeight, Color? fontColor}) {
    return TextStyle(
      fontFamily: 'THSarabun',
      fontSize: fontSize,
      color: fontColor ?? Colors.black87,
      fontWeight: fontWeight ?? FontWeight.normal,
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
}
