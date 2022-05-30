import 'package:app_lma/models/chemical_material.dart';
import 'package:app_lma/widgets/chemical_material_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;
  List<ChemicalMaterialCard> list = [];
  List<ChemicalMaterialCard> foundList = [];

  Future<List<ChemicalMaterial>> _getMaterial() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<ChemicalMaterial> materials = [];
    await db.collection('cabinet').orderBy('name').get().then((event) {
      for (var doc in event.docs) {
        ChemicalMaterial material = ChemicalMaterial.fromJson(doc.data());
        material.id = doc.id;
        materials.add(material);
      }
    });
    return materials;
  }

  void _buildList() async {
    await _getMaterial().then((materials) {
      for (ChemicalMaterial material in materials) {
        setState(() {
          list.add(ChemicalMaterialCard(
            chemicalMaterial: material,
            onPress: () {},
          ));
        });
      }
      setState(() {
        foundList = list;
      });
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ChemicalMaterialCard> results = [];
    if (enteredKeyword.isEmpty) {
      results = list;
    } else {
      results = list
          .where((material) =>
              material.chemicalMaterial.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              material.chemicalMaterial.LMAId
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundList = results;
    });
  }

  @override
  void initState() {
    _controller = TextEditingController();
    _buildList();
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
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 19, 62, 59),
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(6, 12, 24, 12),
              color: const Color.fromARGB(255, 240, 241, 245),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                controller: _controller,
                autofocus: true,
                cursorColor: const Color.fromARGB(255, 19, 62, 59),
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  hintText: 'Buscar',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: foundList.length,
                itemBuilder: (context, index) {
                  return foundList[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
