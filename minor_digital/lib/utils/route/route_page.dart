import 'package:flutter/material.dart';
import 'package:minor_digital/screens/opt.dart';
import 'package:minor_digital/screens/register.dart';
import 'package:minor_digital/screens/splash_screen.dart';
import 'package:minor_digital/screens/success.dart';
import 'package:minor_digital/widgets/countdown.dart';

final Map<String, WidgetBuilder> routes = {
  '/splashScreenPage': (_) => const SplashScreenPage(),
  '/registerPage': (_) => const RegisterPage(),
  '/otpPage': (_) => const OtpPage(),
  '/successPage': (_) => const SuccessPage(),
  '/countdownTimer': (_) => const CountdownTimer(),
};

class Routes {
  Routes._();
  static const String splashScreen = '/splashScreenPage';
  static const String register = '/registerPage';
  static const String otpPage = '/otpPage';
  static const String successPage = '/successPage';
  static const String countdownTimer = '/countdownTimer';
}
