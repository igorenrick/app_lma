import 'package:app_lma/screens/cabinet/add/material_amount_screen.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialSupervisedScreen extends StatefulWidget {
  final String CAS;
  final String name;
  final String LMAId;
  final String type;
  final String suplier;
  const MaterialSupervisedScreen({
    Key? key,
    required this.CAS,
    required this.name,
    required this.LMAId,
    required this.type,
    required this.suplier,
  }) : super(key: key);

  @override
  State<MaterialSupervisedScreen> createState() =>
      _MaterialSupervisedScreenState();
}

enum SupervisedOptions { sim, nao }

class _MaterialSupervisedScreenState extends State<MaterialSupervisedScreen> {
  SupervisedOptions? _option = SupervisedOptions.nao;

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
                    'A substância é controlada pela Polícia Federal?',
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
                      'Não',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    leading: Radio<SupervisedOptions>(
                      value: SupervisedOptions.nao,
                      groupValue: _option,
                      onChanged: (SupervisedOptions? value) {
                        setState(() {
                          _option = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Sim',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    leading: Radio<SupervisedOptions>(
                      value: SupervisedOptions.sim,
                      groupValue: _option,
                      onChanged: (SupervisedOptions? value) {
                        setState(() {
                          _option = value;
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
                    builder: (context) => MaterialAmountScreen(
                      CAS: widget.CAS,
                      name: widget.name,
                      LMAId: widget.LMAId,
                      type: widget.type,
                      suplier: widget.suplier,
                      supervised: _option.toString() == 'SupervisedOptions.sim'
                          ? true
                          : false,
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
