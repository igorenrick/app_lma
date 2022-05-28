import 'package:app_lma/widgets/action_bar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ActionBarButton> actions = [
      ActionBarButton(
        label: 'Escanear',
        onPressed: () {},
      ),
      ActionBarButton(
        label: 'Buscar',
        onPressed: () {},
      ),
    ];
    List<Widget> feed = [
      Container(
        height: (MediaQuery.of(context).size.height / 3) - 56,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 19, 62, 59),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: const Text(
          'Registro',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      Container(
        height: 66,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 12, 40, 38),
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actions.length,
          itemBuilder: (context, index) {
            return actions[index];
          },
        ),
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
          physics: const BouncingScrollPhysics(),
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
