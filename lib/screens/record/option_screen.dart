import 'package:app_lma/models/chemical_material.dart';
import 'package:app_lma/screens/record/replace_screen.dart';
import 'package:app_lma/screens/record/withdrawn_screen.dart';
import 'package:app_lma/widgets/percentage_info_card.dart';
import 'package:app_lma/widgets/square_button.dart';
import 'package:app_lma/widgets/material_info_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image/flutter_image.dart';
import 'package:url_launcher/url_launcher.dart';

class OptionScreen extends StatefulWidget {
  final ChemicalMaterial material;
  const OptionScreen({
    Key? key,
    required this.material,
  }) : super(key: key);

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
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
            height: 150,
            child: Image(
              image: NetworkImageWithRetry(
                  'https://chem.nlm.nih.gov/chemidplus/structure/${material.CAS}'),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
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
        );
        feed.add(
          const SizedBox(
            height: 12,
          ),
        );
        feed.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
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
        );
        feed.add(
          MaterialPercentageInfoCard(
            initialAmount: material.initialAmount,
            currentAmount: material.currentAmount,
            unity: material.type == 'Solvente' ? 'mL' : 'g',
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
            label: 'Marca/Fornecedor',
            value: material.suplier,
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
      });
    });
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SquareButton(
                  label: 'Repor',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReplaceScreen(
                          material: material,
                        ),
                      ),
                    );
                  },
                  backgroundColor: const Color.fromARGB(255, 19, 62, 59),
                  icon: Icons.arrow_circle_down,
                  theme: SquareButtonTheme('light'),
                ),
                SquareButton(
                  label: 'Retirar',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WithdrawnScreen(
                          material: material,
                        ),
                      ),
                    );
                  },
                  backgroundColor: const Color.fromARGB(255, 19, 62, 59),
                  icon: Icons.arrow_circle_up,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
