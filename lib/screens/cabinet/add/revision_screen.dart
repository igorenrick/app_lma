import 'package:app_lma/widgets/revision_item.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RevisionScreen extends StatelessWidget {
  final String CAS;
  final String name;
  final String LMAId;
  final String type;
  final String suplier;
  final bool supervised;
  final double initialAmount;
  final double buyNotification;
  const RevisionScreen({
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
            Flexible(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, top: 24, right: 24),
                    child: Text(
                      'Adicionando $name',
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  RevisionItem(label: 'CAS', value: CAS),
                  RevisionItem(label: 'LMA ID', value: LMAId),
                  RevisionItem(label: 'Tipo', value: type),
                  RevisionItem(label: 'Marca/Fornecedor', value: suplier),
                  RevisionItem(
                      label: 'Controlado pela PF',
                      value: supervised ? 'Sim' : 'Não'),
                  RevisionItem(
                      label: 'Quantidade Inicial',
                      value: initialAmount.toString() +
                          (type == 'Solvente' ? ' mL' : ' g')),
                  RevisionItem(
                      label: 'Notificação de Compra',
                      value: buyNotification.toString() +
                          (type == 'Solvente' ? ' mL' : ' g')),
                ],
              ),
            ),
            SquareButton(
              label: 'Adicionar',
              onPressed: () {},
              backgroundColor: const Color.fromARGB(255, 93, 153, 150),
            ),
          ],
        ),
      ),
    );
  }
}
