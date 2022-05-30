import 'package:app_lma/screens/dashboard_screen.dart';
import 'package:app_lma/screens/home_screen.dart';
import 'package:app_lma/screens/loading_sceen.dart';
import 'package:app_lma/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return const LoadingScreen();
    } else if (auth.user != null && auth.user!.emailVerified) {
      return const DashboardScreen();
    } else {
      return const HomeScreen();
    }
  }
}
