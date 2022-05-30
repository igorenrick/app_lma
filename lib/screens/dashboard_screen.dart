import 'package:app_lma/screens/cabinet/cabinet_screen.dart';
import 'package:app_lma/screens/profile/profile_screen.dart';
import 'package:app_lma/screens/record/record_screen.dart';
import 'package:app_lma/services/auth_service.dart';
import 'package:app_lma/widgets/dashboard_button.dart';
import 'package:app_lma/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileButton(
              label: auth.lmaUser.toString() == 'null'
                  ? ''
                  : '${auth.lmaUser!.name.substring(0, 1)}${auth.lmaUser!.surname.substring(0, 1)}',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              backgroundColor: const Color.fromARGB(255, 126, 205, 201),
            ),
            Column(
              children: [
                DashboardButton(
                  title: 'Armário',
                  label: '',
                  backgroundColor: const Color.fromARGB(255, 93, 153, 150),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CabinetScreen(),
                      ),
                    );
                  },
                ),
                DashboardButton(
                  title: 'Horário',
                  label: '',
                  backgroundColor: const Color.fromARGB(255, 24, 77, 74),
                  onPressed: () {},
                ),
                DashboardButton(
                  title: 'Registro',
                  label: '',
                  backgroundColor: const Color.fromARGB(255, 19, 62, 59),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecordScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
