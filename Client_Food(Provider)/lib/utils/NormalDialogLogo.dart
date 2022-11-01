import 'package:flutter/material.dart';
import 'package:/services/firebaseMessageing.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Null> normalDialogNoLogo(BuildContext context, String string) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: Colors.white,
      title: ListTile(
        title: Column(
          children: [
            Icon(
              Icons.notifications,
              color: Colors.amber,
              size: 40,
            ),
            Text(
              string,
              style: TextStyle(
                color: Colors.black,
              ),
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      children: [
        TextButton(
          onPressed: () async {
            var preferences = await SharedPreferences.getInstance();
            preferences.setString('noticPermission', 'allow');

            FirebaseMessageingMethods().subscribeClient(context);

            Navigator.pop(context);
          },
          child: Text(
            'ALLOW ONLY WHILE USING THE APP',
            style: TextStyle(
              color: Colors.amber,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            var preferences = await SharedPreferences.getInstance();
            preferences.setString('noticPermission', 'deny');

            FirebaseMessageingMethods().subscribeClient(context);

            Navigator.pop(context);
          },
          child: Text(
            'DENY',
            style: TextStyle(
              color: Colors.amber,
            ),
          ),
        ),
      ],
    ),
  );
}
