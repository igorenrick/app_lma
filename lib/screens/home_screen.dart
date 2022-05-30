import 'package:app_lma/screens/authentication/login_screen.dart';
import 'package:app_lma/screens/authentication/register/registration_screen.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 0,
            ),
            Center(
              child: Image.asset(
                'lib/assets/images/logo_lma.png',
                width: 135,
                height: 127,
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SquareButton(
                  label: 'Entrar',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  backgroundColor: const Color.fromARGB(255, 126, 205, 201),
                ),
                SquareButton(
                  label: 'Nova Conta',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
                    );
                  },
                  backgroundColor: const Color.fromARGB(255, 240, 241, 245),
                  labelColor: Colors.black,
                ),
                SquareButton(
                  label: 'Ponto com NFC',
                  onPressed: () {},
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  bottom: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
