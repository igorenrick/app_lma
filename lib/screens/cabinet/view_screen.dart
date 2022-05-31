import 'package:app_lma/models/chemical_material.dart';
import 'package:app_lma/widgets/material_info_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewScreen extends StatefulWidget {
  final ChemicalMaterial material;
  const ViewScreen({
    Key? key,
    required this.material,
  }) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  List<Widget> feed = [];
  late ChemicalMaterial material;

  _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível abrir $url.'),
        ),
      );
    }
  }

  Future<ChemicalMaterial> _getMaterial() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    ChemicalMaterial material = widget.material;
    await db
        .collection('cabinet')
        .where('CAS', isEqualTo: widget.material.CAS)
        .get()
        .then((event) {
      ChemicalMaterial getMaterial =
          ChemicalMaterial.fromJson(event.docs[0].data());
      getMaterial.id = event.docs[0].id;
      material = getMaterial;
    });
    return material;
  }

  void _buildFeed() async {
    await _getMaterial().then((material) {
      setState(() {
        material = material;
        feed.add(
          SizedBox(
            child: Image(
              image: NetworkImageWithRetry(
                  'https://chem.nlm.nih.gov/chemidplus/structure/${widget.material.CAS}'),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const Center(
                    child: Icon(
                      Icons.science_outlined,
                      size: 24,
                      color: Colors.black,
                    ),
                  );
                }
              },
              errorBuilder: (context, exception, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.science_outlined,
                    size: 24,
                    color: Color.fromARGB(255, 142, 142, 147),
                  ),
                );
              },
            ),
          ),
        );
        feed.add(
          MaterialInfoCard(
            label: 'CAS',
            value: material.CAS,
          ),
        );
        feed.add(
          MaterialInfoCard(
            label: 'Tipo',
            value: material.type,
          ),
        );
        feed.add(
          MaterialInfoCard(
            label: 'Marca/Fornecedor',
            value: material.suplier,
          ),
        );
        feed.add(
          MaterialInfoCard(
            label: 'Controlado pela PF',
            value: material.supervised ? 'Sim' : 'Não',
          ),
        );
        feed.add(
          MaterialInfoCard(
            label: 'Quantidade Inicial',
            value:
                '${material.initialAmount.toString()} ${material.type == 'Solvente' ? 'mL' : 'g'}',
          ),
        );
        feed.add(
          MaterialInfoCard(
            label: 'Quantidade Disponível',
            value:
                '${material.currentAmount.toString()} ${material.type == 'Solvente' ? 'mL' : 'g'}',
          ),
        );
        feed.add(
          MaterialInfoCard(
            label: 'Notificação de Compra',
            value:
                '${material.buyNotification.toString()} ${material.type == 'Solvente' ? 'mL' : 'g'}',
          ),
        );
      });
    });
    String date = await material.formatDate();
    setState(
      () {
        feed.add(
          MaterialInfoCard(
            label: 'Cadastrado em',
            value: date,
          ),
        );
        feed.add(
          MaterialInfoCard(
            label: 'Ficha Técnica',
            value: 'Acessar',
            onPressed: () {
              _launchURL(
                Uri.https('chemicalbook.com', '/CASEN_${material.CAS}.htm'),
              );
            },
          ),
        );
        feed.add(
          MaterialInfoCard(
            label: 'Estrutura 3D',
            value: 'Acessar',
            onPressed: () {
              _launchURL(
                Uri.https('chem.nlm.nih.gov',
                    '/chemidplus/structure3D/viewer/${material.CAS}'),
              );
            },
          ),
        );
        feed.add(
          MaterialInfoCard(
            label: 'ChemDraw',
            value: 'Acessar',
            onPressed: () {
              _launchURL(
                Uri.https('chemicalbook.com', '/CAS/mol/${material.CAS}.mol'),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    setState(() {
      material = widget.material;
    });
    _buildFeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 19, 62, 59),
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
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: feed.length,
                itemBuilder: (context, index) {
                  return feed[index];
                },
              ),
            ),
            Container(
              color: const Color.fromARGB(255, 93, 153, 150),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(48, 24, 24, 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      material.LMAId,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 93, 153, 150),
                        fontFamily: 'Roboto',
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    material.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
