import 'package:app_lma/models/chemical_material.dart';
import 'package:app_lma/widgets/action_bar.dart';
import 'package:app_lma/widgets/action_bar_button.dart';
import 'package:app_lma/widgets/cabinet_card.dart';
import 'package:app_lma/widgets/header_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CabinetScreen extends StatefulWidget {
  const CabinetScreen({Key? key}) : super(key: key);

  @override
  State<CabinetScreen> createState() => _CabinetScreenState();
}

class _CabinetScreenState extends State<CabinetScreen> {
  List<ActionBarButton> actions = [
    ActionBarButton(
      label: 'Adicionar',
      onPressed: () {},
    ),
  ];

  List<Widget> feed = [
    const HeaderSection(
      title: 'Armário',
      backgroundColor: Color.fromARGB(255, 93, 153, 150),
    ),
  ];

  Future<List<ChemicalMaterial>> _getMaterial() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<ChemicalMaterial> materials = [];
    await db.collection('cabinet').get().then((event) {
      for (var doc in event.docs) {
        ChemicalMaterial material = ChemicalMaterial.fromJson(doc.data());
        material.id = doc.id;
        materials.add(material);
      }
    });
    return materials;
  }

  void _buildFeed() async {
    feed.add(
      ActionBar(
        actions: actions,
        backgroundColor: const Color.fromARGB(255, 24, 77, 74),
      ),
    );

    await _getMaterial().then((materials) {
      for (ChemicalMaterial material in materials) {
        setState(() {
          feed.add(CabinetCard(chemicalMaterial: material));
        });
      }
    });
  }

  @override
  void initState() {
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
          statusBarColor: Color.fromARGB(255, 93, 153, 150),
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 93, 153, 150),
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
      body: SafeArea(
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: feed.length,
          itemBuilder: (context, index) {
            return feed[index];
          },
        ),
      ),
    );
  }
}
