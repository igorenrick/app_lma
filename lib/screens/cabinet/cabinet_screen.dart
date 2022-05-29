import 'package:app_lma/widgets/action_bar.dart';
import 'package:app_lma/widgets/action_bar_button.dart';
import 'package:app_lma/widgets/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CabinetScreen extends StatelessWidget {
  const CabinetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ActionBarButton> actions = [
      ActionBarButton(
        label: 'Adicionar',
        onPressed: () {},
      ),
    ];
    List<Widget> feed = [
      const HeaderSection(
        title: 'Armário',
        backgroundColor: Color.fromARGB(255, 93, 153, 150),
      ),
      ActionBar(
        actions: actions,
        backgroundColor: const Color.fromARGB(255, 24, 77, 74),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 93, 153, 150),
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 93, 153, 150),
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
