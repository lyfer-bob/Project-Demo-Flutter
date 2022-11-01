import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:/blocs/GetDeviceInfo_provider.dart';
// import 'package:/services/route/ApiPath.dart';
// import 'package:/utils/Constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'blocs/GetDeviceInfo_provider.dart';
import 'screen/AboutUs/provider/globalURL_provider.dart';
import 'services/route/ApiPath.dart';
import 'utils/Constants.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  String? versionFirebase;
  bool canUpdate = false;
  String versionStroe = '';
  String versionApp = '';
  String urlApp = '';

  getDataPreferences() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    //  String? logInStatus = preferences.getString('isLogIn');

    Provider.of<GetDeviceInfoProvider>(context, listen: false).getDeviceInfo();

    Provider.of<GlobalURLProvider>(context, listen: false)
        .getGlobalDataFromAPI();
    Provider.of<GlobalURLProvider>(context, listen: false).enableWriteLog();

    // await Geolocator.requestPermission();

    // _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // Constants().printColorGreen(
    //     '|?| Geolocator.isLocationServiceEnabled:: $_serviceEnabled |?|');

    var maintenanceStatus =
        await Provider.of<GlobalURLProvider>(context, listen: false)
            .maintenanceStatusReturnValue();

    if (maintenanceStatus == true) {
      print('SYSTEM DOWN');
    } else {
      print('SYSTEM MAINTENANCE STATUS :: $maintenanceStatus');
      print('SYSTEM ACTIVE');

      Navigator.pushNamedAndRemoveUntil(context, '/fragment', (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    print('_SplashScreenPageState');
    // set systemNavigationBarColor
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light));
    // getVersionStoreAndroid();
    // getVersionStoreIOS();

    getPath().whenComplete(
      () => updateVersion(context).then(
        (_) {
          if (!canUpdate) getDataPreferences();
        },
      ),
    );
  }

  getVersionStoreAndroid() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String id = packageInfo.packageName;
    final playStore = PlayStoreSearchAPI();
    final response = await (playStore.lookupById(id));
    if (response != null) {
      versionStroe = PlayStoreResults.version(response) ?? '';
    }
  }

  getVersionStoreIOS() async {
    final uri = Uri.https('itunes.apple.com', '/lookup',
        {'bundleId': 'co.xxxxxx.foodOrderyClient'});
    final resp = await http.get(uri);

    if (resp.statusCode == 200) {
      final j = json.decode(resp.body);
      versionStroe = j['results'][0]['version'];
    } else {
      Constants().printColorRed('getversion error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/ic_launcher.png'),
            SizedBox(height: 64),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF5CB13)),
            ),
          ],
        ),
      ),
    );
  }

  Future getPath() async {
    try {
      final db = FirebaseFirestore.instance;

      await db
          .collection('appEndpoint')
          .doc('endpoint')
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        String prodEndPoint = documentSnapshot['prod'].toString();
        String uatEndPoint = documentSnapshot['uat'].toString();
        String uatCloudEndPoint = documentSnapshot['uatcloud'].toString();
        print(
            '\x1B[34m${'firebase path :' + documentSnapshot['prod'].toString()}\x1B[0m');
        print(
            '\x1B[34m${'firebase path :' + documentSnapshot['uat'].toString()}\x1B[0m');
        if (ApiPath.routeEndpoint == 'uat') {
          ApiPath.apiURL = '$uatEndPoint/v3/';
          ApiPath.globalApiURL = '$uatEndPoint/v3/GlobalApi';
          ApiPath().isDev = false;
          ApiPath().isGolive = false;
        } else if (ApiPath.routeEndpoint == 'prod') {
          ApiPath.apiURL = '$prodEndPoint/v3/';
          ApiPath.globalApiURL = '$prodEndPoint/v3/GlobalApi';
          ApiPath().isDev = false;
          ApiPath().isGolive = true;
        } else if (ApiPath.routeEndpoint == 'uatcloud') {
          ApiPath.apiURL = '$uatCloudEndPoint/v3/';
          ApiPath.globalApiURL = '$uatCloudEndPoint/v3/GlobalApi';
          ApiPath().isDev = false;
          ApiPath().isGolive = false;
        }
      });
    } catch (e) {
      if (ApiPath.routeEndpoint == 'uat' ||
          ApiPath.routeEndpoint == 'uatcloud') {
        ApiPath.apiURL = '';
        ApiPath.globalApiURL = '';
        ApiPath().isDev = false;
        ApiPath().isGolive = false;
      } else if (ApiPath.routeEndpoint == 'prod') {
        ApiPath.apiURL = '';
        ApiPath.globalApiURL = '';
        ApiPath().isDev = false;
        ApiPath().isGolive = true;
      }
    }
  }

  String replaceString(originalString) {
    final original = '$originalString';
    final find = '.';
    final replaceWith = '';
    final newString = original.replaceAll(find, replaceWith);

    return newString;
  }

  Future updateVersion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isIOS) {
      await getVersionStoreIOS();
      urlApp = '';
    } else {
      await getVersionStoreAndroid();
      urlApp = '';
    }

    versionApp = packageInfo.version;
    prefs.setString('version', packageInfo.version);
    int currentVersion = int.parse(replaceString(versionApp));
    int newVersion = int.parse(replaceString(versionStroe));

    Constants().printColorCyan(currentVersion.toString());
    Constants().printColorCyan(newVersion.toString());

    if (currentVersion < newVersion) {
      canUpdate = true;

      customShowUpdateDialog(context);
    }
  }

  void customShowUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Update Available',
          style: Constants().textStyleData(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(bottom: 15),
                child: Constants().showLogo(),
              ),
              Row(
                children: [
                  Text(
                    'กรุณาอัพเดตเวอร์ชั่นเป็น  ',
                    style: Constants().textStyleData(),
                  ),
                  Text(
                    '$versionStroe',
                    style:
                        Constants().textStyleData(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                '(เวอร์ชั่นปัจจุบัน $versionApp)',
                style: Constants().textStyleData(font: 18),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: Text(
                'อัพเดต',
                style: Constants().textStyleData(fontColor: Colors.blueAccent),
              ),
              onPressed: () {
                // ignore: deprecated_member_use
                launch(urlApp);
              }),
        ],
      ),
    );

    // Future updateVersionFormFirebase() async {
    //   // SharedPreferences? prefs = await SharedPreferences.getInstance();
    //   bool isGolive = ApiPath().isGolive;
    //   bool isDev = ApiPath().isDev;

    //   try {
    //     final db = FirebaseFirestore.instance;

    //     await db
    //         .collection('version')
    //         .doc('client')
    //         .get()
    //         .then((DocumentSnapshot documentSnapshot) {
    //       String prodPublishAndroid =
    //           documentSnapshot['prod_publish_vs_android'].toString();
    //       String prodPublishIOS =
    //           documentSnapshot['prod_publish_vs_ios'].toString();
    //       String prodDevAndroid =
    //           documentSnapshot['prod_dev_vs_android'].toString();
    //       String prodDevIOS = documentSnapshot['prod_dev_vs_ios'].toString();
    //       String uatDevAndroid =
    //           documentSnapshot['uat_dev_vs_android'].toString();
    //       String uatDevIOS = documentSnapshot['uat_dev_vs_ios'].toString();

    //       if (Platform.isAndroid) {
    //         if (isGolive && !isDev) {
    //           Constants().printColorYellow('Android prod : $prodPublishAndroid');
    //           versionFirebase = prodPublishAndroid;
    //         } else if (isDev) {
    //           Constants().printColorYellow('Android dev : $prodDevAndroid');
    //           versionFirebase = prodDevAndroid;
    //         } else {
    //           Constants().printColorYellow('Android uat : $uatDevAndroid');
    //           versionFirebase = uatDevAndroid;
    //         }
    //       } else {
    //         if (!isGolive && !isDev) {
    //           Constants().printColorYellow('ios uat : $uatDevIOS');
    //           versionFirebase = uatDevIOS;
    //         } else if (isDev) {
    //           Constants().printColorYellow('ios dev : $prodDevIOS');
    //           versionFirebase = prodDevIOS;
    //         } else {
    //           Constants().printColorYellow('ios prod : $prodPublishIOS');
    //           versionFirebase = prodPublishIOS;
    //         }
    //       }
    //     });
    //   } catch (e) {
    //     Constants().printColorRed(e.toString());
    //   }
    // }
  }
}
