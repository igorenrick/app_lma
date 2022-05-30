import 'package:app_lma/screens/dashboard_screen.dart';
import 'package:app_lma/services/auth_service.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _loginController, _passwordController;
  bool isLoading = false;

  login() async {
    try {
      setState(() {
        isLoading = true;
      });
      await context
          .read<AuthService>()
          .login(_loginController.text, _passwordController.text);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login efetuado com sucesso!'),
        ),
      );

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
        ModalRoute.withName('/dashboard'),
      );
    } on AuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 93, 153, 150),
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.west,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 24, top: 24),
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 12),
                  child: Text(
                    'Seu email',
                    style: TextStyle(
                      color: Color.fromARGB(255, 142, 142, 147),
                      fontFamily: 'Roboto',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: TextField(
                    controller: _loginController,
                    autofocus: true,
                    cursorColor: const Color.fromARGB(255, 126, 205, 201),
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'seuemail@exemplo.com',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 142, 142, 147),
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 12),
                  child: Text(
                    'Sua senha',
                    style: TextStyle(
                      color: Color.fromARGB(255, 142, 142, 147),
                      fontFamily: 'Roboto',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: TextField(
                    controller: _passwordController,
                    autofocus: false,
                    obscureText: true,
                    cursorColor: const Color.fromARGB(255, 126, 205, 201),
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Minha senha',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 142, 142, 147),
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                auth.user != null
                    ? auth.user!.emailVerified
                        ? const SizedBox(
                            height: 0,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: TextButton(
                              onPressed: () {
                                auth.user!.sendEmailVerification();
                              },
                              style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft,
                              ),
                              child: const Text(
                                'Reenviar email de verificação',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 126, 205, 201),
                                  fontFamily: 'Rubik',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          )
                    : const SizedBox(
                        height: 0,
                      ),
              ],
            ),
            isLoading
                ? const Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 126, 205, 201),
                      ),
                    ),
                  )
                : SquareButton(
                    label: 'Entrar',
                    onPressed: () {
                      login();
                    },
                    backgroundColor: const Color.fromARGB(255, 126, 205, 201),
                    bottom: true,
                  ),
          ],
        ),
      ),
    );
  }
}
