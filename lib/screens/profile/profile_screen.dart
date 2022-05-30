import 'package:app_lma/screens/home_screen.dart';
import 'package:app_lma/services/auth_service.dart';
import 'package:app_lma/widgets/action_bar.dart';
import 'package:app_lma/widgets/action_bar_button.dart';
import 'package:app_lma/widgets/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void logout() async {
    try {
      await context.read<AuthService>().logout();

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
          builder: (context) => const HomeScreen(),
        ),
        ModalRoute.withName('/'),
      );
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ActionBarButton> actions = [
      ActionBarButton(
        label: 'Editar',
        onPressed: () {},
      ),
      ActionBarButton(
        label: 'Sair',
        onPressed: () {
          logout();
        },
      ),
    ];
    List<Widget> feed = [
      const HeaderSection(
        title: 'Perfil',
        backgroundColor: Color.fromARGB(255, 126, 205, 201),
      ),
      ActionBar(
        actions: actions,
        backgroundColor: const Color.fromARGB(255, 93, 153, 150),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 126, 205, 201),
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 126, 205, 201),
        leading: IconButton(
          icon: const Icon(
            Icons.west,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: feed.length,
          itemBuilder: (context, index) {
            return feed[index];
          },
        ),
      ),
    );
  }
}
