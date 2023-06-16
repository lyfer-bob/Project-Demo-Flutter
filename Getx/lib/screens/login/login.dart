import 'package:project/screens/package.dart';

class LoginPages extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
        init: controller,
        initState: (_) {
          controller.init();
        },
        builder: (_) => Scaffold(
                body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Assets.images.backgroundLogin.image(),
                Image.asset(
                  'assets/images/background_login.png',
                  fit: BoxFit.cover,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Container(
                            height: 460,
                            width: 90.w,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 25,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40, bottom: 10),
                                  child: TextApp(
                                      text:
                                          'Please enter email and password to access.',
                                      fontSize: 13,
                                      fontColor: Constants().fontColor),
                                ),
                                _getFormUI(context),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )));
  }

  Widget _getFormUI(BuildContext context) {
    return Column(
      children: <Widget>[
        _email(),
        const SizedBox(height: 20.0),
        _password(),
        _submit(context),
      ],
    );
  }

  Padding _submit(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50, bottom: 20),
      child: ButtonSubmit(
        width: 50.w,
        height: 50,
        text: 'Login',
        backgroundColor: controller.stsLogin.value
            ? Constants().orange
            : Constants().grayLightButton,
        fontColor: Constants().white,
        fontSize: 15,
        onPressed: controller.stsLogin.value
            ? () => controller.loginAction(context)
            : null,
      ),
    );
  }

  Container _password() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Constants().fontColor,
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        onChanged: (value) => controller.changeStsLogin(),
        controller: controller.password.value,
        autofocus: false,
        obscureText: controller.obscureText.value ? true : false,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          fillColor: Constants().white,
          hintText: 'Password',
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Constants().white,
              width: 3.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Constants().orangeLight,
            ),
          ),
          filled: true,
          prefixIcon: const Icon(
            Icons.lock,
            color: Colors.orangeAccent,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              controller.visiblePassword(!controller.obscureText.value);
            },
            child: Icon(
              controller.obscureText.value
                  ? Icons.visibility
                  : Icons.visibility_off,
              semanticLabel: controller.obscureText.value
                  ? 'show password'
                  : 'hide password',
            ),
          ),
        ),
      ),
    );
  }

  Container _email() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Constants().fontColor,
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        onChanged: (value) => controller.changeStsLogin(),
        controller: controller.email.value,
        decoration: InputDecoration(
          fillColor: Constants().white,
          filled: true,
          prefixIcon: Icon(
            Icons.mail,
            color: Constants().orangeLight,
          ),
          hintText: 'Email',
          contentPadding: const EdgeInsets.fromLTRB(
            20.0,
            10.0,
            20.0,
            10.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Constants().white,
              width: 3.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Constants().orangeLight,
            ),
          ),
        ),
      ),
    );
  }
}
