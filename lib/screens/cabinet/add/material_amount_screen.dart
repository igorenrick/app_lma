import 'package:app_lma/screens/cabinet/add/revision_screen.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialAmountScreen extends StatefulWidget {
  final String CAS;
  final String name;
  final String LMAId;
  final String type;
  final String suplier;
  final bool supervised;
  const MaterialAmountScreen({
    Key? key,
    required this.CAS,
    required this.name,
    required this.LMAId,
    required this.type,
    required this.suplier,
    required this.supervised,
  }) : super(key: key);

  @override
  State<MaterialAmountScreen> createState() => _MaterialAmountScreenState();
}

class _MaterialAmountScreenState extends State<MaterialAmountScreen> {
  late TextEditingController _initialAmountController,
      _buyNotificationController;

  @override
  void initState() {
    super.initState();
    _initialAmountController = TextEditingController();
    _buyNotificationController = TextEditingController();
  }

  @override
  void dispose() {
    _initialAmountController.dispose();
    _buyNotificationController.dispose();
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
                    'Informe as quantidades abaixo',
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
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    'Inicial',
                    style: TextStyle(
                      color: Color.fromARGB(255, 142, 142, 147),
                      fontFamily: 'Roboto',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 48),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      TextField(
                        controller: _initialAmountController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        autofocus: true,
                        cursorColor: const Color.fromARGB(255, 126, 205, 201),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'qntd',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 142, 142, 147),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        widget.type == 'Solvente' ? 'mL' : 'g',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    'Notificação de Compra',
                    style: TextStyle(
                      color: Color.fromARGB(255, 142, 142, 147),
                      fontFamily: 'Roboto',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 48),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      TextField(
                        controller: _buyNotificationController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        autofocus: true,
                        cursorColor: const Color.fromARGB(255, 126, 205, 201),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'qntd',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 142, 142, 147),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Text(
                        widget.type == 'Solvente' ? 'mL' : 'g',
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SquareButton(
              label: 'Continuar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RevisionScreen(
                      CAS: widget.CAS,
                      name: widget.name,
                      LMAId: widget.LMAId,
                      type: widget.type,
                      suplier: widget.suplier,
                      supervised: widget.supervised,
                      initialAmount:
                          double.parse(_initialAmountController.text),
                      buyNotification:
                          double.parse(_buyNotificationController.text),
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
