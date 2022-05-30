import 'package:app_lma/screens/cabinet/add/material_name_screen.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialCASScreen extends StatefulWidget {
  const MaterialCASScreen({Key? key}) : super(key: key);

  @override
  State<MaterialCASScreen> createState() => _MaterialCASScreenState();
}

class _MaterialCASScreenState extends State<MaterialCASScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.only(left: 24, top: 24, right: 24),
                  child: Text(
                    'Qual o CAS da substância que será adicionada?',
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
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: TextField(
                controller: _controller,
                autofocus: true,
                cursorColor: const Color.fromARGB(255, 126, 205, 201),
                style: const TextStyle(
                  fontSize: 22,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '00-00-0',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 142, 142, 147),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SquareButton(
              label: 'Continuar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MaterialName(
                      CAS: _controller.text,
                    ),
                  ),
                );
              },
              backgroundColor: const Color.fromARGB(255, 93, 153, 150),
            ),
          ],
        ),
      ),
    );
  }
}
