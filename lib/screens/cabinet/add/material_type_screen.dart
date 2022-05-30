import 'package:app_lma/screens/cabinet/add/material_suplier_screen.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialTypeScreen extends StatefulWidget {
  final String CAS;
  final String name;
  final String LMAId;
  const MaterialTypeScreen({
    Key? key,
    required this.CAS,
    required this.name,
    required this.LMAId,
  }) : super(key: key);

  @override
  State<MaterialTypeScreen> createState() => _MaterialTypeScreenState();
}

enum MaterialTypes { reagente, solvente }

class _MaterialTypeScreenState extends State<MaterialTypeScreen> {
  MaterialTypes? _type = MaterialTypes.reagente;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                    'Qual o tipo da substância?',
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
              padding: const EdgeInsets.only(left: 0, right: 24),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      'Reagente',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    leading: Radio<MaterialTypes>(
                      value: MaterialTypes.reagente,
                      groupValue: _type,
                      onChanged: (MaterialTypes? value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Solvente',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    leading: Radio<MaterialTypes>(
                      value: MaterialTypes.solvente,
                      groupValue: _type,
                      onChanged: (MaterialTypes? value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SquareButton(
              label: 'Continuar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MaterialSuplierScreen(
                      CAS: widget.CAS,
                      name: widget.name,
                      LMAId: widget.LMAId,
                      type: _type.toString() == 'MaterialTypes.solvente'
                          ? 'Solvente'
                          : 'Reagente',
                    ),
                  ),
                );
              },
              backgroundColor: const Color.fromARGB(255, 93, 153, 150),
              bottom: true,
            ),
          ],
        ),
      ),
    );
  }
}
