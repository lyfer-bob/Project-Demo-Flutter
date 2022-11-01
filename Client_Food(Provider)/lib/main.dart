import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:upgrader/upgrader.dart';
import 'blocs/auth_bloc.dart';
import 'services/route/ProviderRoute.dart';
import 'services/route/ServiceRoute.dart';
import 'utils/Constants.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final onNotifications = BehaviorSubject<String?>();

const MethodChannel platform = MethodChannel('');

String? selectedNotificationPayload;

/// To verify things are working, check out the native platform logs.
Future<Null> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print('recieveTimeData:: ${DateTime.now()}');
  print('title:: ${message.notification!.title}');
  print('body:::::::: ${message.notification!.body}');
  print('data:: ${message.data}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only call clearSavedSettings() during testing to reset internal values.
  WidgetsFlutterBinding.ensureInitialized();
  await Upgrader.clearSavedSettings(); // REMOVE this for release builds

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //when app is close
  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload = notificationAppLaunchDetails!.payload;
  }

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final IOSInitializationSettings iosInitializationSettings =
      IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: true,
    // onDidReceiveLocalNotification:
    //     // FirebaseMessageingMethods().onDidReceiveLocalNotification,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      selectedNotificationPayload = payload;
      onNotifications.add(payload);
    },
  );

  await Firebase.initializeApp().then(
    (value) async {
      // Pass all uncaught errors from the framework to Crashlytics.
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
    },
  );

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      '', // id
      '', // title
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(''),
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );
  }

  HttpOverrides.global = new MyHttpOverrides();

  runApp(
    MultiProvider(
      providers: routeMultiProvider(),
      child: MainApp(),
    ),
  );
}

//
// String initRoute = '/testPage';
String initRoute = '/splashScreenPage';

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();

    _firebaseCrash();
  }

  void _firebaseCrash() async {
    if (kIsWeb) {
      // Force disable Crashlytics collection while doing every day development.
      // Temporarily toggle this to true if you want to test crash reporting in your app.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      // Handle Crashlytics enabled status when not in Debug,
      // e.g. allow your users to opt-in to crash reporting.

      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'THSarabun',
          primaryColor: Constants.themeColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // canvasColor: Colors.transparent,
        ),
        routes: routes,
        initialRoute: initRoute,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  // อนุญาติให้ใช่งานในกรณีปิด ssl ได้
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
