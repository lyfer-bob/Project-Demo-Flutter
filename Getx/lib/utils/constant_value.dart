import 'package:flutter/material.dart';

class Constants {
  static const MaterialColor themeColor = MaterialColor(
    0xFF3D525C,
    <int, Color>{
      50: Color(0xD53D525C),
      100: Color(0x1A3D525C),
      200: Color(0x333D525C),
      300: Color(0x4D3D525C),
      400: Color(0x663D525C),
      500: Color(0x803D525C),
      600: Color(0x993D525C),
      700: Color(0xB33D525C),
      800: Color(0xCC3D525C),
      900: Color(0xE63D525C),
    },
  );

  static const MaterialColor darkThemeColor = MaterialColor(
    0xFF3D525C,
    <int, Color>{
      50: Color(0x0D687e89),
      100: Color(0x1A687e89),
      200: Color(0x33687e89),
      300: Color(0x4D687e89),
      400: Color(0x66687e89),
      500: Color(0x80687e89),
      600: Color(0x99687e89),
      700: Color(0xB3687e89),
      800: Color(0xCC687e89),
      900: Color(0xE6687e89),
    },
  );
  Color fontColor = const Color(0xffC4C4C4);
  Color grayLight = const Color(0xff9E9E9E);
  Color grayLightButton = Color.fromARGB(172, 135, 132, 132);
  Color grayLightShadow = const Color(0xfff5f5f5);
  Color grayDark = const Color(0xff636363);
  Color orange = const Color(0xffff7800); //0xffFF7800
  Color orangeLight = const Color(0xffff9b3b); //0xffFF9B3B
  Color purple = const Color(0xff8e7cf6); //0xff8E7CF6
  Color sky = const Color(0xff6ad8fd); //0xff6AD8FD
  Color pink = const Color(0xfffe88bc); //0xffFE88BC
  Color yellow = const Color(0xffface2d); //0xffFACE2D
  Color yellowDark = const Color(0xffffc44f); //0xffFACE2D
  Color greenLight = const Color(0xff32cc8c); //0xff32CC8C
  Color green = const Color(0xff00b50c); //0xff00B50C
  Color black = const Color(0xff000000);
  Color white = const Color(0xffFFFFFF);
  Color red = const Color(0xffdc1d00); //0xffDC1D00

  bool isEmail(String string) {
    // Null or empty string is invalid
    if (string.isEmpty) {
      return false;
    }

    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  Widget showLogo() => Image.asset('assets/images/ic_launcher.png');

  Widget progressAPI() {
    return const Center(
        child: SizedBox(
            width: 100, height: 100, child: CircularProgressIndicator()));
  }

  Constants();
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
