import 'package:flutter/material.dart';
import 'package:/blocs/auth_bloc.dart';
import 'package:/blocs/forgetpassword_provider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  TextEditingController emailStrControl = TextEditingController();

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
    var loginProvider = Provider.of<ForgotPasswordProvider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Color(0xff3D525C),
        //   toolbarHeight: MediaQuery.of(context).size.height / 5,
        //   leading: IconButton(
        //       icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        //       onPressed: () => Navigator.pop(context)),
        //   centerTitle: true,
        //   title: logoEatHub(),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //       bottom: Radius.circular(48.0),
        //     ),
        //   ),
        // ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                headerBar(),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Image.asset(
                      //   'assets/images/lock_ic.png',
                      //   height: 80,
                      //   width: 80,
                      //   fit: BoxFit.fill,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Constants()
                            .fontStyleBold('ลืมรหัสผ่าน', fontSize: 24),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child:
                            Constants().fontStyleRegular('อีเมล', fontSize: 24),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          controller: emailStrControl,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Color(0xFFFEBC18),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            // hintText: 'อีเมล',
                            // hintStyle: TextStyle(fontSize: 16),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
                          ),
                        ),
                      ),
                      ButtonAccept(
                        onPressed: () {
                          if (emailStrControl.text.length == 0) {
                            normalDialog(context, 'กรุณากรอกอีเมล');
                          } else {
                            loginProvider.forgetPasswordWithEmailToAPI(
                              context,
                              emailStrControl.text,
                            );
                          }
                        },
                        text: 'ยืนยัน',
                        fontSize: 21,
                        fontColor: Colors.white,
                        backgroundColor: Color(0xFFFEBC18),
                        height: 50,
                        fontStyleRegular: false,
                      ),
                      linerOr(),
                      ButtonAccept(
                        onPressed: () => {
                          Navigator.pushNamed(context, '/sendForgotPassOTP')
                        },
                        text: 'ส่งข้อความไปที่ SMS',
                        fontSize: 21,
                        fontColor: Colors.white,
                        backgroundColor: Constants().textColor,
                        height: 50,
                        fontStyleRegular: false,
                      ),
                      buttonCancel()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget logoEatHub() {
    return Image.asset(
      'assets/images/logopng.png',
      height: 150,
      width: 150,
      fit: BoxFit.cover,
    );
  }

  Widget linerOr() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.grey,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Constants().fontStyleRegular('หรือ',
                  fontSize: 21, colorValue: Colors.grey),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }

  Widget buttonCancel() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => {Navigator.pop(context)},
            child: Constants().fontStyleRegular('ยกเลิก',
                fontSize: 21, colorValue: Colors.grey),
          )
        ],
      ),
    );
  }

  Widget headerBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
          color: Color(0xff3D525C), //Filling colour
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(48.0),
          ) //Roundness
          ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 50, 24, 0),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () => (Navigator.pop(context)),
                  child: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: logoEatHub(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
