import 'package:flutter/material.dart';
import 'package:/utils/Constants.dart';
import 'ButtonAccept.dart';

class ReasonForCancellationPage extends StatefulWidget {
  const ReasonForCancellationPage({Key? key}) : super(key: key);

  @override
  _ReasonForCancellationPageState createState() =>
      _ReasonForCancellationPageState();
}

class _ReasonForCancellationPageState extends State<ReasonForCancellationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Constants().fontStyleBold('ยกเลิกงาน')),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width * 0.9,
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            textTitle(context),
            textMessage(context),
            btnSendMessage(context),
            btnCancel(context),
          ],
        ),
      ),
    );
  }

  Widget textTitle(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Constants().fontStyleBold('โปรดระบุเหตุผล', fontSize: 24)],
        ),
      ),
    );
  }

  Widget textMessage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      padding: EdgeInsets.all(4.0),
      height: 140.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ]),
      child: SizedBox.expand(
        child: TextFormField(
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            hintText: 'โปรดระบุเหตุผล',
            hintStyle: TextStyle(fontSize: 14, color: Color(0xFFC0C0C0)),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          ),
          minLines: 5,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          style: TextStyle(fontSize: 14, color: Color(0xFFC0C0C0)),
        ),
      ),
    );
  }

  Widget btnSendMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ButtonAccept(
        onPressed: () => {},
        text: 'ส่ง',
        fontColor: Colors.white,
        backgroundColor: Color(0xFFFEBC18),
        width: MediaQuery.of(context).size.width * 0.80,
        height: 60,
      ),
    );
  }

  Widget btnCancel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ButtonAccept(
        onPressed: () => {},
        text: 'ยกเลิก',
        fontStyleRegular: true,
        fontColor: Colors.black,
        backgroundColor: Color(0xFFDADADA),
        width: MediaQuery.of(context).size.width * 0.80,
        height: 60,
      ),
    );
  }
}
