import 'package:app_lma/models/chemical_material.dart';
import 'package:app_lma/screens/dashboard_screen.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WithDrawnConfirmationScreen extends StatefulWidget {
  final ChemicalMaterial material;
  final DateTime date;
  final double amount;
  final String userLmaId;
  const WithDrawnConfirmationScreen({
    Key? key,
    required this.material,
    required this.date,
    required this.amount,
    required this.userLmaId,
  }) : super(key: key);

  @override
  State<WithDrawnConfirmationScreen> createState() =>
      _WithDrawnConfirmationScreenState();
}

class _WithDrawnConfirmationScreenState
    extends State<WithDrawnConfirmationScreen> {
  late int percent = 0;
  late String message = '';

  void _sendMaterial() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    setState(() {
      percent = 30;
      message = 'Verificando se está tudo certo...';
    });

    final record = <String, dynamic>{
      'CAS': widget.material.CAS,
      'materialId': widget.material.id,
      'recordDate': Timestamp.fromDate(widget.date),
      'amount': widget.amount,
      'type': 'Saída',
      'userId': widget.userLmaId,
    };

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      percent = 60;
      message = 'Enviando os dados para os servidores...';
    });

    await db.collection('records').add(record).then(
      (DocumentReference doc) {
        print('DocumentSnapshot added with ID: ${doc.id}');
      },
    );

    await db.collection('cabinet').doc(widget.material.id).update({
      'currentAmount': widget.material.currentAmount - widget.amount,
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      percent = 100;
      message = 'Registro adicionado com sucesso!';
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
              progressColor: const Color.fromARGB(255, 19, 62, 59),
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
                  backgroundColor: const Color.fromARGB(255, 19, 62, 59),
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
