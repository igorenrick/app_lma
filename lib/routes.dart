import 'package:app_lma/screens/cabinet/cabinet_screen.dart';
import 'package:app_lma/screens/dashboard_screen.dart';
import 'package:app_lma/screens/record/record_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/dashboard': (_) => const DashboardScreen(),
    '/record': (_) => const RecordScreen(),
    '/cabinet': (_) => const CabinetScreen()
  };

  static String initial = '/dashboard';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
