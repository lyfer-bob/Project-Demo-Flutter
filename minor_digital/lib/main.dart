import 'package:minor_digital/utils/core_package.dart';
import 'package:minor_digital/utils/route/route_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: routeMultiProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Minor Digital',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'THSarabun',
          primaryColor: const Color.fromARGB(255, 73, 170, 249),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes,
        initialRoute: Routes.splashScreen,
      );
    });
  }
}
