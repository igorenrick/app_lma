import 'package:app_lma/screens/authentication/register/verify_email_screen.dart';
import 'package:app_lma/screens/cabinet/cabinet_screen.dart';
import 'package:app_lma/screens/dashboard_screen.dart';
import 'package:app_lma/screens/home_screen.dart';
import 'package:app_lma/screens/record/record_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/': (_) => const HomeScreen(),
    '/dashboard': (_) => const DashboardScreen(),
    '/record': (_) => const RecordScreen(
          user: null,
        ),
    '/cabinet': (_) => const CabinetScreen(),
    '/verifyemail': (_) => const VerifyEmailScreen(),
  };

  static String initial = '/dashboard';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
