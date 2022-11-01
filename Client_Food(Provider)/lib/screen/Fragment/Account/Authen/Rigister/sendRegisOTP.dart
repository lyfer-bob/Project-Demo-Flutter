import 'package:flutter/material.dart';
import 'package:/screen/Fragment/Account/Authen/provider/RigisterProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

class RegisterWithOTPPage extends StatefulWidget {
  const RegisterWithOTPPage({Key? key}) : super(key: key);

  @override
  _RegisterWithOTPPageState createState() => _RegisterWithOTPPageState();
}

class _RegisterWithOTPPageState extends State<RegisterWithOTPPage> {
  TextEditingController phoneController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    phoneController.text =
        Provider.of<RegisterProvider>(context, listen: false).phoneNoValue;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) phoneController.text = arguments.toString();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Consumer<RegisterProvider>(builder: (context, pvd, child) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                headerBar(),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Constants()
                      .fontStyleBold('หมายเลขโทรศัพท์', fontSize: 24),
                ),
                inputNumber(context),
                Container(
                  margin: EdgeInsets.all(20),
                  child: ButtonAccept(
                    onPressed: () {
                      pvd.requestRegisterWithOTP(
                          context, phoneController.text.toString());
                    },
                    text: 'รับรหัส OTP',
                    height: 50,
                    fontColor: Colors.white,
                    // fontSize: 30,
                    backgroundColor: Constants().defaultColor,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Container inputNumber(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) phoneController.text = arguments.toString();
    print('arguments=>> ${phoneController.text}');
    return Container(
      margin: EdgeInsets.fromLTRB(20, 4, 20, 0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          // Card(
          //   elevation: 3,
          //   child: Padding(
          //     padding:
          //         const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
          //     child: Row(
          //       children: <Widget>[
          //         Image.asset(
          //           'assets/images/thailand.png',
          //           width: 35,
          //           height: 45,
          //         ),
          //         Container(
          //           margin: EdgeInsets.only(left: 5),
          //           child: Constants().fontStyleBold('+66'),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: Card(
              elevation: 3,
              child: textField('Phone Number', phoneController),
            ),
          ),
        ],
      ),
    );
  }

  Padding textField(String label, TextEditingController _controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 8),
      child: Container(
        // height: 60,
        child: TextField(
            style: TextStyle(
              fontFamily: 'THSarabun',
              fontSize: 24,
              // height: 1.8,
              fontWeight: FontWeight.bold,
            ),
            controller: _controller,
            keyboardType: TextInputType.phone,
            cursorColor: Color(0xff737373),
            onChanged: (newValue) {
              // _controller.text = newValue;
              // print(_controller);
            },
            maxLength: 11,
            autocorrect: false,
            // inputFormatters: [
            //   MaskedInputFormatter('###-###-####'),
            // ],
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              counterText: '',
            )
            // hintText: phoneController.text),
            // label: Text(phoneController.text) ,)
            // labelText: phoneController.text,)
            ),
      ),
    );
  }

  Widget logoEatHub() {
    return Image.asset(
      'assets/images/logopng.png',
      height: 150,
      width: 150,
      fit: BoxFit.cover,
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
