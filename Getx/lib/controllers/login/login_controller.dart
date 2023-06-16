import 'package:project/controllers/pagekage.dart';

class LoginController extends GetxController {
  final to = Get.find<LoginController>();

  LoginRepository repoLogin = LoginRepository();
  MenuCController repoMenu = MenuCController();

  final email = TextEditingController().obs;
  final password = TextEditingController().obs;

  var loginModel = LoginModel().obs;
  var isLoadingLogin = false.obs;
  var errorLoading = false.obs;

  var loginReq = Login();
  var obscureText = true.obs;
  var stsLogin = false.obs;

  Future init() async {
    isLoadingLogin.value = false;
    errorLoading.value = false;
    // ctr2.init();
  }

  Future<void> loginAction(BuildContext context) async {
    if (repoLogin.validateData(
        email.value.text, password.value.text, context)) {
      loginReq.userNameOrEmailAddress = email.value.text;
      loginReq.password = password.value.text;

      Get.toNamed(SDBRoutes.demo);

      try {
        print('login action');
        // Todo : call api
        //   loginModel.value = await repoLogin.requestLogin(loginReq);
      } catch (e) {
        print('error data');
        // errorLoading = true.obs;
        errorLoading = false.obs; // mock
      }
      isLoadingLogin.value = true;
    }
  }

  void visiblePassword(bool value) {
    obscureText.value = value;
  }

  void changeStsLogin() {
    stsLogin.value =
        repoLogin.getStsLogin(email.value.text, password.value.text);
  }
}
