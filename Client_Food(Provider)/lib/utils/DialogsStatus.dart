import 'package:ProjectName/screen/Fragment/FragmentProvider.dart';
import 'package:ProjectName/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:flutter/material.dart';
import 'Constants.dart';
import 'package:provider/provider.dart';

Future<Null> statusDialog(BuildContext context, String string,
    {onPressed, String? text}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
          leading: Constants().showLogo(),
          title: Text(
            string,
            style: TextStyle(
                fontFamily: 'THSarabun',
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          )),
      children: [
        Consumer<FragmentProvider>(
          builder: (context, pvd, child) => TextButton(
              onPressed: onPressed ??
                  () {
                    pvd.changeIndexpage(4);
                    pvd.stsSigin = false;
                    Navigator.popUntil(
                        context, ModalRoute.withName('/fragment'));

                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, '/signInPage', (route) => false);
                  },

              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => SignInPage()),
              //     ModalRoute.withName('/')),

              child: Constants().fontStyleRegular(text ?? 'ตกลง',
                  fontSize: 20, colorValue: Colors.amber)),
        )
      ],
    ),
  );
}

Future<Null> statusRegisterDialog(BuildContext context, String string,
    {onPressed, String? text}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
          leading: Constants().showLogo(),
          title: Text(
            string,
            style: TextStyle(
                fontFamily: 'THSarabun',
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          )),
      children: [
        TextButton(
            onPressed: onPressed ?? () => Navigator.pop(context),
            // Navigator.popUntil(
            //       context,
            //       ModalRoute.withName('/register'),
            //     ),

            // Navigator.pushNamedAndRemoveUntil(
            //     context, '/register', (route) => false),
            child: Constants().fontStyleRegular(text ?? 'ตกลง',
                fontSize: 20, colorValue: Colors.amber)),
      ],
    ),
  );
}

Future<Null> loginThirdPartyDialog(BuildContext context, String string,
    {onPressed, String? text}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
          leading: Constants().showLogo(),
          title: Text(
            string,
            style: TextStyle(
                fontFamily: 'THSarabun',
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          )),
      children: [
        TextButton(
          child: Text('ตกลง'),
          onPressed: () {
            //Navigator.pop(context);

            // Navigator.popUntil(
            //   context,
            //   ModalRoute.withName('/profile'),
            // );

            Navigator.pushNamed(context, '/profile');
          },
        ),
      ],
    ),
  );
}

Future<void> dialogSignInSusses(context, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            Image.asset(
              'assets/images/logo.jpg',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 8,
            ),
            Text(text),
          ],
        ),
        actions: <Widget>[
          Consumer3<RestaurantMainProvider, FragmentProvider,
              AddressSavePageProvider>(
            builder: (context, pvdrest, pvd, pvdAddrs, child) => TextButton(
              child: Text('ตกลง'),
              onPressed: () async {
                await pvd.initSigin(context);
                pvdrest.getDataListMenuMain(
                    latitude: pvdAddrs.showAddress.latitude,
                    longitude: pvdAddrs.showAddress.longitude,
                    context: context,
                    flagPage: 'MainFlagment');
                Navigator.popUntil(context, ModalRoute.withName('/fragment'));
              },
            ),
          ),
        ],
      );
    },
  );
}
