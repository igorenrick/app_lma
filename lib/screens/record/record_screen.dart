import 'package:app_lma/models/record.dart';
import 'package:app_lma/models/user.dart';
import 'package:app_lma/screens/record/record_card.dart';
import 'package:app_lma/screens/record/scanner_screen.dart';
import 'package:app_lma/screens/record/search_screen.dart';
import 'package:app_lma/widgets/action_bar.dart';
import 'package:app_lma/widgets/action_bar_button.dart';
import 'package:app_lma/widgets/header_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecordScreen extends StatefulWidget {
  final LMAUser? user;
  const RecordScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  List<ActionBarButton> actions = [];

  List<Widget> feed = [];

  Future<List<Record>> _getRecords() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<Record> records = [];
    await db
        .collection('records')
        .where(
          'userId',
          isEqualTo: widget.user!.id,
        )
        .orderBy('recordDate', descending: true)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        Record record = Record.fromJson(doc.data());
        record.id = doc.id;
        records.add(record);
      }
    });
    return records;
  }

  void _buildFeed() async {
    setState(() {
      actions = [
        ActionBarButton(
          label: 'Escanear',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScannerScreen(),
              ),
            );
          },
        ),
        ActionBarButton(
          label: 'Buscar',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ),
            );
          },
        ),
      ];
      feed = [
        const HeaderSection(
          title: 'Registro',
          backgroundColor: Color.fromARGB(255, 19, 62, 59),
        ),
        ActionBar(
          actions: actions,
          backgroundColor: const Color.fromARGB(255, 12, 40, 38),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(24, 36, 24, 12),
          child: Text(
            'Meus Registros',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ];
    });

    await _getRecords().then((records) {
      for (Record record in records) {
        setState(() {
          feed.add(RecordCard(
            record: record,
          ));
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
