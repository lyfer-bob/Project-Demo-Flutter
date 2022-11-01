import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Constants {
  Color textColor = Color(0xff3D525C);
  Color defaultColor = Color(0xffFEBC18);

  static const MaterialColor themeColor = MaterialColor(
    0xFFFEBC18,
    <int, Color>{
      50: Color(0x0D5FEBC18),
      100: Color(0x1AFEBC18),
      200: Color(0x33FEBC18),
      300: Color(0x4DFEBC18),
      400: Color(0x66FEBC18),
      500: Color(0x80FEBC18),
      600: Color(0x99FEBC18),
      700: Color(0xB3FEBC18),
      800: Color(0xCCFEBC18),
      900: Color(0xE6FEBC18),
    },
  );

  void printColorRed(String text) {
    print('\x1B[31m$text\x1B[0m');
  }

  void printColorGreen(String text) {
    print('\x1B[32m$text\x1B[0m');
  }

  void printColorYellow(String text) {
    print('\x1B[33m$text\x1B[0m');
  }

  void printColorBlue(String text) {
    print('\x1B[34m$text\x1B[0m');
  }

  void printColorMagenta(String text) {
    print('\x1B[35m$text\x1B[0m');
  }

  void printColorCyan(String text) {
    print('\x1B[36m$text\x1B[0m');
  }

  bool isEmail(String? string) {
    // Null or empty string is invalid
    if (string == null || string.isEmpty) {
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

  static const EdgeInsets paddingAppLR = EdgeInsets.only(left: 20, right: 20);
  static const EdgeInsets paddingAppLRT =
      EdgeInsets.only(left: 20, right: 20, top: 10);
  static const EdgeInsets paddingAppLRB =
      EdgeInsets.only(left: 20, right: 20, bottom: 10);
  static const EdgeInsets paddingAppLRTB =
      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10);

  Widget showLogo() => Image.asset('assets/images/ic_launcher.png');

  Container flexibleSpaceInAppBar() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.0, -1.0),
            end: Alignment(0.0, 1.0),
            colors: [
              Colors.white,
              Colors.white,
            ],
            stops: [0.0, 1.0],
          ),
        ),
      );

  Container flexibleSpaceInAppBar2() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment(0.0, -1.0),
            end: Alignment(0.0, 1.0),
            colors: [
              Colors.white,
              Colors.white,
            ],
            stops: [0.0, 1.0],
          ),
        ),
      );

  Widget leadingBackIconAppBar(context, {onPressed}) => IconButton(
      icon: Icon(Icons.arrow_back_ios, color: Colors.black),
      onPressed: onPressed ?? () => Navigator.of(context).pop());

  Widget leadingBackIconAppBarNew(context, {onPressed}) => Padding(
        padding:
            const EdgeInsets.only(left: 18.5, top: 10, bottom: 10, right: 7),
        child: Container(
          // margin: const EdgeInsets.fromLTRB(7, 6.5, 7, 6.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFF3D525C),
          ),
          child: Center(
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: onPressed ?? () => Navigator.of(context).pop()),
          ),
        ),
      );

  Text fontStyleBold(String title,
      {Color? colorValue, double? fontSize, TextOverflow? overflow}) {
    colorValue ??= Colors.black;
    fontSize ??= 24.0;

    return Text(
      title,
      overflow: overflow ?? TextOverflow.fade,
      style: TextStyle(
          fontFamily: 'THSarabun',
          fontSize: fontSize,
          color: colorValue,
          fontWeight: FontWeight.bold),
    );
  }

  Text fontStyleRegular(String title,
      {Color? colorValue, double? fontSize, TextOverflow? overflow}) {
    colorValue ??= Colors.black;
    fontSize ??= 17.0;
    return Text(
      title,
      overflow: overflow ?? TextOverflow.fade,
      softWrap: false,
      style: TextStyle(
          fontFamily: 'THSarabun',
          fontSize: fontSize,
          color: colorValue,
          fontWeight: FontWeight.normal),
    );
  }

  Text fontStyleRegularUnderLine(String title,
      {Color? colorValue, double? fontSize}) {
    colorValue ??= Colors.black;
    fontSize ??= 17.0;
    return Text(
      title,
      overflow: TextOverflow.fade,
      maxLines: 1,
      softWrap: false,
      style: TextStyle(
          decoration: TextDecoration.underline,
          fontFamily: 'THSarabun',
          fontSize: fontSize,
          color: colorValue,
          fontWeight: FontWeight.bold),
    );
  }

  // Future<Null> dialogProgress(BuildContext context, {bool pop = false}) async {
  //   pop
  //       ? Navigator.pop(context);
  //       : showDialog(
  //           barrierDismissible: false,
  //           context: context,
  //           builder: (context) => SpinKitPouringHourGlass(
  //             color: Colors.amber,
  //             size: 100,
  //           ),
  //         );
  // }

  Widget textAutoNewLine(String title,
      {Color? colorValue, double? fontSize, bool? alignCenter}) {
    return Row(
      mainAxisAlignment: alignCenter == true
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: alignCenter == true
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    height: 1,
                    fontFamily: 'THSarabun',
                    fontSize: fontSize ?? 17.0,
                    color: colorValue ?? Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextStyle textStyleRegular({double? fontSize, Color? colorValue}) =>
      TextStyle(
          fontFamily: 'THSarabun',
          overflow: TextOverflow.ellipsis,
          fontSize: fontSize ?? 18,
          color: colorValue ?? Colors.black,
          fontWeight: FontWeight.normal);

  TextStyle textStyleBold({double? fontSize, Color? colorValue}) => TextStyle(
      fontFamily: 'THSarabun',
      overflow: TextOverflow.ellipsis,
      fontSize: fontSize ?? 18,
      color: colorValue ?? Colors.black,
      fontWeight: FontWeight.bold);

  String priceFormat(var price) {
    String? result;

    double priceParse =
        double.parse(price.toString().isEmpty ? '0' : price.toString());
    var formatter = NumberFormat('#,###,###.00');
    List<String> _price = formatter.format(priceParse).split('.');

    if (_price[1].substring(0, 1) == '0' && _price[1].substring(1) == '0') {
      result = _price.first;
    } else {
      if (_price[1].substring(1) == '0') {
        result = priceParse.toStringAsFixed(1);
      } else
        result = priceParse.toStringAsFixed(2);
    }

    return result.isEmpty ? '0' : result;
  }

  Widget textNotSuccess(BuildContext context, String text) => Center(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: textAutoNewLine(text,
              fontSize: 50, colorValue: Colors.grey, alignCenter: true),
        ),
      );

  String priceDecimal(data) => num.parse(data.toString()).toStringAsFixed(2);

  String dateTimeTHFormat(
      {String? dateTime, String? formatDate, bool? dateOnly}) {
    bool _dateOnly = dateOnly ?? false;
    DateFormat dateFormat = DateFormat(formatDate ?? "yyyy-MM-ddTHH:mm:ss");
    DateTime _dateTime = dateFormat.parse(dateTime!);

    String day = DateFormat('d').format(_dateTime);
    String month = DateFormat('M').format(_dateTime);
    String year =
        (int.parse(DateFormat('yyyy').format(_dateTime)) + 543).toString();

    String time = '';
    if (_dateOnly == false) time = DateFormat('Hm').format(_dateTime);

    switch (month) {
      case '1':
        month = 'ม.ค.';
        break;

      case '2':
        month = 'ก.พ.';
        break;
      case '3':
        month = 'มี.ค.';
        break;
      case '4':
        month = 'เม.ย.';
        break;
      case '5':
        month = 'พ.ค.';
        break;
      case '6':
        month = 'มิ.ย.';
        break;
      case '7':
        month = 'ก.ค.';
        break;
      case '8':
        month = 'ส.ค.';
        break;
      case '9':
        month = 'ก.ย.';
        break;
      case '10':
        month = 'ต.ค.';
        break;
      case '11':
        month = 'พ.ย.';
        break;
      case '12':
        month = 'ธ.ค.';
        break;
      default:
    }

    return '$day $month $year${_dateOnly == false ? " - $time" : ''}';
  }

  void bottomSheet(context, Widget widget, double height, Color bgcolor) {
    // call demo bottomSheetCancelBook
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: bgcolor,
        context: context,
        builder: (BuildContext bc) {
          return DraggableScrollableSheet(
              initialChildSize: height,
              maxChildSize: height,
              minChildSize: height,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return CustomScrollView(
                  //  controller: scrollController,
                  slivers: [
                    SliverFillRemaining(hasScrollBody: false, child: widget),
                  ],
                );
              });
        });
  }

  Widget progressAPI() {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        child: CupertinoActivityIndicator.partiallyRevealed(
          radius: 20,
        ),
      ),
    );
  }

  Widget typeTabBar(BuildContext context, String value, {double? fontSize}) {
    var constants = Constants();
    return Container(
      width: double.infinity,
      height: 50,
      color: Color(0xFFF3F3F3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: paddingAppLR,
            child: constants.fontStyleBold(value,
                fontSize: fontSize ?? 24.00, colorValue: Color(0xFF3D525C)),
          ),
        ],
      ),
    );
  }

  Constants();
}
