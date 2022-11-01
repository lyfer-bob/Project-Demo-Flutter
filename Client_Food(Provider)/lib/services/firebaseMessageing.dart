import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:/model/FromJSON/firebaseMessageingModel.dart';
import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:/screen/chat/providers/ChatArgument_provider.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/NormalDialogLogo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class FirebaseMessageingMethods {
  FirebaseMessageingMethods();

  FirebaseMessageDataModel? messageData;

  String? autoAccept, noticType, fakeNoticPermission;

  int? orderid;

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void unSubscribeClient(BuildContext context) async {
    print('unSubscribeClient');

    var preferences = await SharedPreferences.getInstance();
    String? clientID = preferences.getString('id').toString();
    String? custDeviceId = preferences.getString('custDeviceId');

    fakeNoticPermission = preferences.getString('noticPermission');
    bool isGetGolive = ApiPath().isGolive;

    if (isGetGolive) {
      //  PROD Server //
      await FirebaseMessaging.instance.unsubscribeFromTopic(
          '${preferences.getString('platform')}_APPORDERING_$clientID');

      await FirebaseMessaging.instance.unsubscribeFromTopic(
          '${preferences.getString('platform')}_APPORDERING_$custDeviceId');
    } else {
      //  UAT Server //
      await FirebaseMessaging.instance.unsubscribeFromTopic(
          '${preferences.getString('platform')}_APPORDERING_${clientID}_${ApiPath.routeEndpoint}');

      await FirebaseMessaging.instance.unsubscribeFromTopic(
          '${preferences.getString('platform')}_APPORDERING_${custDeviceId}_${ApiPath.routeEndpoint}');
    }
  }

  void subscribeClient(BuildContext context) async {
    var preferences = await SharedPreferences.getInstance();

    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    String? platform;
    //String? deviceId;

    bool isGetGolive = ApiPath().isGolive;

    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      platform = 'android';
      //  deviceId = build.androidId.toString();
      build.androidId.toString();
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      platform = 'ios';
      // deviceId = data.identifierForVendor.toString();
      data.identifierForVendor.toString();
    }

    String? clientID = preferences.getString('id').toString();
    String? custDeviceId = preferences.getString('custDeviceId');
    fakeNoticPermission = preferences.getString('noticPermission');

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: false,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      if (Platform.isAndroid) {
        if (fakeNoticPermission == 'allow') {
          if (isGetGolive) {
            //  PROD Server //

            await FirebaseMessaging.instance
                .subscribeToTopic('${platform}_APPORDERING_$clientID');

            await FirebaseMessaging.instance
                .subscribeToTopic('${platform}_APPORDERING_$custDeviceId');
          } else {
            //  UAT Server //

            await FirebaseMessaging.instance.subscribeToTopic(
                '${platform}_APPORDERING_${clientID}_${ApiPath.routeEndpoint}');

            await FirebaseMessaging.instance.subscribeToTopic(
                '${platform}_APPORDERING_${custDeviceId}_${ApiPath.routeEndpoint}');
          }
        } else if (fakeNoticPermission == 'deny') {
          if (isGetGolive) {
            //  PROD Server //
            await FirebaseMessaging.instance.unsubscribeFromTopic(
                '${preferences.getString('platform')}_APPORDERING_$clientID');

            await FirebaseMessaging.instance.unsubscribeFromTopic(
                '${preferences.getString('platform')}_APPORDERING_$custDeviceId');
          } else {
            //  UAT Server //

            await FirebaseMessaging.instance.unsubscribeFromTopic(
                '${preferences.getString('platform')}_APPORDERING_${clientID}_${ApiPath.routeEndpoint}');

            await FirebaseMessaging.instance.unsubscribeFromTopic(
                '${preferences.getString('platform')}_APPORDERING_${custDeviceId}_${ApiPath.routeEndpoint}');
          }
        } else {
          normalDialogNoLogo(context,
              "Allow \n xxxxxx Client \n to access  this device's \n notification?");
        }
      } else if (Platform.isIOS) {
        if (isGetGolive) {
          //  PROD Server //
          await FirebaseMessaging.instance.subscribeToTopic(
              '${preferences.getString('platform')}_APPORDERING_$clientID');

          await FirebaseMessaging.instance
              .subscribeToTopic('${platform}_APPORDERING_$custDeviceId');
        } else {
          //  UAT Server //
          await FirebaseMessaging.instance.subscribeToTopic(
              '${preferences.getString('platform')}_APPORDERING_${clientID}_${ApiPath.routeEndpoint}');

          await FirebaseMessaging.instance.subscribeToTopic(
              '${platform}_APPORDERING_${custDeviceId}_${ApiPath.routeEndpoint}');
        }
      } else {}
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        print('FirebaseMessaging.onMessage:::::${message.data}');

        recieveDataFromFirebaseMessageing(message, context);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        print('FirebaseMessaging.onMessageOpenedApp:::::${message.data}');

        recieveDataFromFirebaseMessageingOnOpenedApp(message, context);
      },
    );
  }

  Future recieveDataFromFirebaseMessageing(
      RemoteMessage message, BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? custDeviceId = preferences.getString('custDeviceId');

    print('title:: ${message.notification!.title}');
    print('body:: ${message.notification!.body}');
    print('data:: ${message.data}');

    messageData = FirebaseMessageDataModel.fromJson(message.data);

    messageData!.notitype.toString() == 'order'
        ? preferences.setString('orderID', messageData!.orderid.toString())
        : preferences.setString('chatID', messageData!.orderid.toString());

    preferences.setString('noticType', messageData!.notitype.toString());

    await _showNotificationCustomSound(message);

    if (messageData!.notitype.toString() == 'order') {
    } else if (messageData!.notitype.toString() == 'promotion') {
      //Navigator.pushNamed(context, '/showNoticPage');
    } else {
      if (messageData!.notitype.toString() == 'messages-customer-restaurant' ||
          messageData!.notitype.toString() == 'messages-customer-rider') {
        Constants().printColorMagenta(
            '||||||| recieveDataFromFirebaseMessageing |||||||');

        Constants().printColorMagenta('||||||| Notic Chat Messages |||||||');
        Constants().printColorMagenta(
            '||||||| ${messageData!.notitype.toString()} |||||||');
        Constants().printColorMagenta('||||||| ${message.data} |||||||');

        List<String> noticData = [];

        noticData.add(messageData!.notitype.toString());
        noticData.add(messageData!.orderid.toString());
        noticData.add(messageData!.ordernumber.toString());
        noticData.add(custDeviceId!);

        Provider.of<ChatArgumentProvider>(context, listen: false)
            .initFirebaseChat(noticData);
      } else {
        print('Out Of case.');

        print('noticData[0]:::: ${messageData!.notitype}');

        Navigator.pushNamed(context, '/fragment');
      }
    }

    Provider.of<GlobalURLProvider>(context, listen: false).noticListAPI();
  }

  Future<Null> recieveDataFromFirebaseMessageingOnOpenedApp(
      RemoteMessage message, BuildContext context) async {
    Provider.of<GlobalURLProvider>(context, listen: false).noticListAPI();

    messageData = FirebaseMessageDataModel.fromJson(message.data);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? custDeviceId = preferences.getString('custDeviceId');

    autoAccept = preferences.getString('autoAccept');

    if (messageData!.notitype == 'messages-customer-restaurant' ||
        messageData!.notitype == 'messages-customer-rider') {
      Constants().printColorMagenta(
          '||||||| recieveDataFromFirebaseMessageingOnOpenedApp |||||||');

      Constants().printColorMagenta('||||||| Notic Chat Messages |||||||');
      Constants().printColorMagenta('||||||| ${message.data} |||||||');

      List<String> noticData = [];

      noticData.add(messageData!.notitype.toString());
      noticData.add(messageData!.orderid.toString());
      noticData.add(messageData!.ordernumber.toString());
      noticData.add(custDeviceId!);

      Provider.of<ChatArgumentProvider>(context, listen: false)
          .initFirebaseChat(noticData);
    } else {
      print(
          'FirebaseMessaging.onMessageOpenedApp::::: ${messageData!.notitype}');
      Navigator.pushNamed(context, '/showNoticPage');
    }
  }

  Future<void> _showNotificationCustomSound(RemoteMessage message) async {
    // RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification?.android;

    var preferences = await SharedPreferences.getInstance();

    // var rawNonce = generateNonce();
    // var rawSHA256 = sha256ofString(rawNonce);

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      //'FoodOrdery_client_$rawSHA256',
      '',
      '',
      channelDescription: '${message.notification!.body}',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
      playSound: true,
      sound: RawResourceAndroidNotificationSound(''),
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: '');

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.show(
        messageData!.notitype.toString() == 'messages-customer-restaurant' ||
                messageData!.notitype.toString() == 'messages-customer-rider'
            ? int.parse('${preferences.getString('chatID').toString()}')
            : messageData!.notitype.toString() == 'promotion'
                ? 0000
                : int.parse('${preferences.getString('orderID').toString()}'),
        '${message.notification!.title}', //'Order Income',
        '${message.notification!.body}', //'คำสั่งซื้อ EH-BKK-210224-00012',
        platformChannelSpecifics,
        payload: messageData!.notitype.toString() ==
                    'messages-customer-restaurant' ||
                messageData!.notitype.toString() == 'messages-customer-rider'
            ? '${messageData!.notitype.toString()}_${messageData!.orderid}_${messageData!.ordernumber.toString()}_${preferences.getString('clientID')}'
            : '${messageData!.notitype.toString()}_${messageData!.orderid}',
      );
    } else if (Platform.isIOS) {
      //setting IOS
    }
  }

  onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    // display a dialog with the notification details, tap ok to go to another page

    print('||||||| onDidReceiveLocalNotification |||||||');
    print('recieveTimeData:: ${DateTime.now()}');
    print('title:: $title');
    print('body:: $body');
    print('data:: $payload');
  }
}
