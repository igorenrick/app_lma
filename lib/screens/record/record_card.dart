import 'package:app_lma/models/chemical_material.dart';
import 'package:app_lma/models/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecordCard extends StatefulWidget {
  final Record record;
  const RecordCard({
    Key? key,
    required this.record,
  }) : super(key: key);

  @override
  State<RecordCard> createState() => _RecordCardState();
}

class _RecordCardState extends State<RecordCard> {
  late ChemicalMaterial material =
      ChemicalMaterial('', '', '', '', '', false, Timestamp(0, 0), 0, 0, 0, '');
  late String date = '';

  void _getMaterial() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    date = await widget.record.formatDate();
    await db
        .collection('cabinet')
        .doc(widget.record.materialId)
        .get()
        .then((value) {
      if (value.toString().isNotEmpty) {
        var data = value.data();
        data!.addAll({'id': value.id});

        setState(() {
          material = ChemicalMaterial.fromJson(data);
          date = date;
        });
      }
    });
  }

  @override
  void initState() {
    _getMaterial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(255, 240, 241, 245),
            ),
            child: Icon(
              widget.record.type == 'Entrada'
                  ? Icons.arrow_circle_down
                  : Icons.arrow_circle_up,
              color: const Color.fromARGB(255, 142, 142, 147),
            ),
          ),
          const SizedBox(
            width: 24,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      date,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromARGB(255, 142, 142, 147),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  material.name,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  '${widget.record.type == 'Saída' ? 'Retirado' : 'Reposto'} ${widget.record.amount} ${material.getUnity()}',
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color.fromARGB(255, 142, 142, 147),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
