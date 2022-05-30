import 'package:app_lma/screens/dashboard_screen.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AddConfirmationScreen extends StatefulWidget {
  final String CAS;
  final String name;
  final String LMAId;
  final String type;
  final String suplier;
  final bool supervised;
  final double initialAmount;
  final double buyNotification;
  const AddConfirmationScreen({
    Key? key,
    required this.CAS,
    required this.name,
    required this.LMAId,
    required this.type,
    required this.suplier,
    required this.supervised,
    required this.initialAmount,
    required this.buyNotification,
  }) : super(key: key);

  @override
  State<AddConfirmationScreen> createState() => _AddConfirmationScreenState();
}

class _AddConfirmationScreenState extends State<AddConfirmationScreen> {
  late int percent = 0;
  late String message = '';

  void _sendMaterial() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    setState(() {
      percent = 30;
      message = 'Verificando se está tudo certo...';
    });

    final material = <String, dynamic>{
      'CAS': widget.CAS,
      'LMAId': widget.LMAId,
      'buyNotification': widget.buyNotification,
      'currentAmount': widget.initialAmount,
      'initialAmount': widget.initialAmount,
      'name': widget.name,
      'registrationDate': Timestamp.now(),
      'supervised': widget.supervised,
      'suplier': widget.suplier,
      'type': widget.type,
    };

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      percent = 60;
      message = 'Enviando os dados para os servidores...';
    });

    await db.collection('cabinet').add(material).then(
      (DocumentReference doc) {
        print('DocumentSnapshot added with ID: ${doc.id}');
      },
    );

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      percent = 100;
      message = '${widget.name} adicionado com sucesso!';
    });
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    _sendMaterial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 48),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontSize: 28,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: LinearPercentIndicator(
              animation: true,
              animationDuration: 1000,
              lineHeight: 10.0,
              width: MediaQuery.of(context).size.width - 48,
              percent: percent / 100,
              progressColor: const Color.fromARGB(255, 93, 153, 150),
              backgroundColor: const Color.fromARGB(255, 242, 242, 247),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          percent == 100
              ? SquareButton(
                  label: 'Ok',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(),
                      ),
                      ModalRoute.withName('/dashboard'),
                    );
                  },
                  backgroundColor: const Color.fromARGB(255, 93, 153, 150),
                  bottom: true,
                )
              : const SizedBox(
                  height: 64,
                ),
        ],
      ),
    );
  }
}
