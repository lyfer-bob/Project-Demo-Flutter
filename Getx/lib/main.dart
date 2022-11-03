import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/controllers/login/login_binding.dart';
import 'package:project/utils/device_info.dart';
import 'package:project/page/login/login.dart';
import 'package:project/service/route/route_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'service/dependency.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // add dependency
  DependencyCreator.init();

// use get storage
  await GetStorage.init('SdbStorage');
  // get data from device
  await GetDeviceInfoProvider().getDeviceInfo();

// intialize firebase core function
  // await Firebase.initializeApp();
  // use firebase_crashlytics
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

// Disble landscape
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

// Initialize Service Routes
  // await getInitService();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    useInheritedMediaQuery: true,
    theme: ThemeData(primarySwatch: Colors.deepOrange),
    home: LoginPages(),
    getPages: SDBPages.pages,
    initialBinding: LoginBinding(),
    // routes: ,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      // home: LoginPages(),
      // getPages: SDBPages.pages,
    );
  }
}
