import 'package:minor_digital/controllers/regeister_controller.dart';
import 'package:minor_digital/utils/core_package.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPage();
}

class _SplashScreenPage extends State<SplashScreenPage> {
  @override
  @override
  void initState() {
    initAsyn();
    super.initState();
  }

  Future initAsyn() async {
    await context.read<RegisterController>().getToken();

    Future.delayed(const Duration(seconds: 2))
        .then((value) => Navigator.pushNamed(context, Routes.register));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 64),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 73, 170, 249)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
