import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:/blocs/auth_bloc.dart';
import 'package:/blocs/login_provider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:provider/provider.dart';

class SendPhoneNumberPage extends StatefulWidget {
  const SendPhoneNumberPage({Key? key}) : super(key: key);

  @override
  _SendPhoneNumberPageState createState() => _SendPhoneNumberPageState();
}

class _SendPhoneNumberPageState extends State<SendPhoneNumberPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController phoneNumberStrControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    authBloc.currentUser.listen((firebaseUser) {
      if (firebaseUser != null) {
        print('FirebaseUser:: ${firebaseUser.providerData[0].providerId}');
      } else {
        print('NO FirebaseUser');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/lock_ic.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Constants().fontStyleRegular(
                          'ระบุเบอร์โทรศัพท์ของคุณ',
                          fontSize: 21),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Flexible(
                        fit: FlexFit.tight,
                        child: TextFormField(
                          controller: phoneNumberStrControl,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9.,]+')),
                          ],
                          autofocus: false,
                          decoration: InputDecoration(
                            // labelText: "ระบุเบอร์โทรศัพท์ของคุณ",
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.amber,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.amber,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Constants().fontStyleRegular(
                          'เราจะส่ง OTP เบอร์โทรศัพท์ของคุณเพื่อยืนยันตัวตน',
                          fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Consumer<LoginProvider>(
                        builder: (context, pvd, child) => ButtonAccept(
                          onPressed: () => {
                            if (phoneNumberStrControl.text ==
                                authBloc.signInModel!.result!.customerPhone
                                    .toString())
                              {
                                pvd.requestOTPToAPI(
                                  context,
                                  phoneNumberStrControl.text,
                                )
                              }
                            else
                              {
                                normalDialog(context,
                                    'เบอร์โทรศัพท์ของคุณไม่ตรงกับที่เคยลงทะเบียนไว้')
                              }
                          },
                          text: 'ยืนยัน',
                          fontSize: 16,
                          fontColor: Colors.white,
                          backgroundColor: Color(0xFFFEBC18),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 40,
                        ),
                      ),
                    ),
                    ButtonAccept(
                      onPressed: () => {Navigator.pop(context)},
                      text: 'ยกเลิก',
                      fontSize: 16,
                      fontColor: Colors.black,
                      backgroundColor: Color(0xFFFDADADA),
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
