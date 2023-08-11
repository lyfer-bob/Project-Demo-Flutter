import 'package:minor_digital/controllers/regeister_controller.dart';
import 'package:minor_digital/utils/core_package.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  @override
  void initState() {
    context.read<RegisterController>().init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Consumer<RegisterController>(
              builder: (context, regist, child) => SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.w),
                      child: SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Minor Digital',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 40,
                                    color: Colors.blue),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Column(
                                children: [
                                  textFieldRow(
                                    'First Name',
                                    regist.fname,
                                    stsError: regist.fnameSts,
                                  ),
                                  textFieldRow(
                                    'Last Name',
                                    regist.lname,
                                    stsError: regist.lnameSts,
                                  ),
                                  textFieldRow(
                                    'Mobile',
                                    regist.mobile,
                                    stsError: regist.mobileSts,
                                    textInputType: TextInputType.number,
                                    errortext: regist.errorTextMobile,
                                  ),
                                  ButtonAccept(
                                    height: 50,
                                    backgroundColor: regist.stsSubmitcheck()
                                        ? const Color(0xFF5ABF6F)
                                        : Colors.grey,
                                    fontColor: Colors.white,
                                    onPressed: regist.stsSubmitcheck()
                                        ? () => regist.submitRegist(context)
                                        : null,
                                    text: 'Submit',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))),
    );
  }

  Widget textFieldRow(String value, TextEditingController controller,
      {TextInputType? textInputType, String? errortext, bool? stsError}) {
    return Consumer<RegisterController>(
      builder: (context, regist, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: (_) => regist.onChangeTextFieldRegist(value),
              keyboardType: textInputType ?? TextInputType.text,
              maxLength: value == 'Mobile' ? 10 : 500,
              inputFormatters: value == 'First Name' || value == 'Last Name'
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                    ]
                  : <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
              decoration: InputDecoration(
                counterText: "",
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 73, 170, 249)),
                ),
                hintStyle: const TextStyle(fontSize: 17),
                hintText: '$value.. ',
                contentPadding:
                    const EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
              ),
            ),
            Visibility(
              visible: stsError!,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(errortext ?? 'Please fill in this form',
                    style: const TextStyle(color: Colors.red, fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
