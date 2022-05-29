import 'package:app_lma/screens/record/scanner_screen.dart';
import 'package:app_lma/widgets/action_bar.dart';
import 'package:app_lma/widgets/action_bar_button.dart';
import 'package:app_lma/widgets/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ActionBarButton> actions = [
      ActionBarButton(
        label: 'Escanear',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScannerScreen(),
            ),
          );
        },
      ),
      ActionBarButton(
        label: 'Buscar',
        onPressed: () {},
      ),
    ];
    List<Widget> feed = [
      const HeaderSection(
        title: 'Registro',
        backgroundColor: Color.fromARGB(255, 19, 62, 59),
      ),
      ActionBar(
        actions: actions,
        backgroundColor: const Color.fromARGB(255, 12, 40, 38),
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Text(
          'Meus Registros',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 19, 62, 59),
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 19, 62, 59),
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
