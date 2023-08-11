import 'package:minor_digital/controllers/regeister_controller.dart';
import 'package:minor_digital/utils/core_package.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPage();
}

class _SuccessPage extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<RegisterController>(builder: (context, regist, chide) {
      return SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 40,
                    color: Color(0xFF5ABF6F))),
            const Text('Minor Digital',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 40,
                    color: Color(0xFF5ABF6F))),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 150),
              child: Text('${regist.fname.text}     ${regist.lname.text}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 40,
                      color: Colors.blue)),
            ),
            const FittedBox(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('by Thanapol Thong - art',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 40,
                        color: Color.fromARGB(255, 226, 194, 12))),
              ),
            )
          ],
        ),
      );
    }));
  }
}
