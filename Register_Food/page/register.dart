import 'package:flutter/material.dart';
import 'package:project_test/blocs/nation/register_provider.dart';

import 'package:provider/provider.dart';

import '../../utils/constant_value.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  void initState() {
    super.initState();
    Provider.of<RegisterProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<RegisterProvider>(
          builder: (context, pvd, child) => IconButton(
            onPressed: () {
              if (pvd.currentTitle == 1) {
                pvd.setPage(0);
              } else if (pvd.currentTitle == 2) {
                pvd.setPage(1);
              } else if (pvd.currentTitle == 3) {
                pvd.setPage(2);
              } else {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName("/requestOTPRegister"));
              }
            },
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Constants().fontStyleBold('ลงทะเบียนร้านค้า'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Consumer<RegisterProvider>(
            builder: (context, pvd, child) => Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                pvd.currentPageWidget!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
