import 'package:app_lma/models/chemical_material.dart';
import 'package:app_lma/screens/record/option_screen.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late bool loading = true;
  late String message = 'Leia um QR Code para buscar as informações.';
  late ChemicalMaterial material =
      ChemicalMaterial('', '', '', '', '', false, Timestamp(0, 0), 0, 0, 0, '');

  void _getMaterial(String code) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db
        .collection('cabinet')
        .where('CAS', isEqualTo: code)
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        ChemicalMaterial foundMaterial =
            ChemicalMaterial.fromJson(event.docs[0].data());
        foundMaterial.id = event.docs[0].id;
        setState(() {
          material = foundMaterial;
          message = 'CAS encontrado de nome ${material.name}';
          loading = false;
        });
      } else {
        setState(() {
          message = 'CAS $code não encontrado.';
          loading = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height / 3) * 2,
            color: Colors.black,
            child: MobileScanner(
                allowDuplicates: false,
                controller: MobileScannerController(
                    facing: CameraFacing.back, torchEnabled: false),
                onDetect: (barcode, args) {
                  if (barcode.rawValue == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Falha ao ler QR Code.'),
                      ),
                    );
                  } else {
                    final String code = barcode.rawValue!;
                    setState(() {
                      message = 'Buscando CAS $code nos servidores.';
                    });
                    _getMaterial(code);
                  }
                }),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: loading
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                            child: Text(
                              message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 142, 142, 147),
                                fontFamily: 'Roboto',
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                              child: Text(
                                material.type,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 142, 142, 147),
                                  fontFamily: 'Roboto',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                              child: Text(
                                material.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Roboto',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                loading
                    ? const SizedBox(
                        height: 48,
                      )
                    : SquareButton(
                        label: 'Selecionar',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OptionScreen(material: material),
                            ),
                          );
                        },
                        backgroundColor: const Color.fromARGB(255, 19, 62, 59),
                        bottom: true,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
