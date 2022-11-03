import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../text/text_app.dart';

class ErrorLoading extends StatelessWidget {
  const ErrorLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.red,
              size: 50,
            ),
            TextApp(
              text: 'ระบบขัดข้องกรุณาติดต่อเจ้าหน้าที่',
              fontSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
