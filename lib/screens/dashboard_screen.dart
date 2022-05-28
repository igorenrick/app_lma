import 'package:app_lma/screens/record/record_screen.dart';
import 'package:app_lma/widgets/dashboard_button.dart';
import 'package:app_lma/widgets/profile_button.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileButton(
              label: 'AC',
              onPressed: () {},
              backgroundColor: const Color.fromARGB(255, 126, 205, 201),
            ),
            Column(
              children: [
                DashboardButton(
                  title: 'Armário',
                  label: 'Ver tudo',
                  backgroundColor: const Color.fromARGB(255, 93, 153, 150),
                  onPressed: () {},
                ),
                DashboardButton(
                  title: 'Horário',
                  label: 'Ver mais',
                  backgroundColor: const Color.fromARGB(255, 24, 77, 74),
                  onPressed: () {},
                ),
                DashboardButton(
                  title: 'Registro',
                  label: 'Controlar',
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
