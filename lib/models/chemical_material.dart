import 'package:cloud_firestore/cloud_firestore.dart';

class ChemicalMaterial {
  late String id;
  final String name;
  final String CAS;
  final String type;
  final String LMAId;
  final bool supervised;
  final Timestamp registrationDate;
  final double initialAmount;
  final double currentAmount;
  final double buyNotification;
  final String suplier;

  ChemicalMaterial(
    this.id,
    this.name,
    this.CAS,
    this.type,
    this.LMAId,
    this.supervised,
    this.registrationDate,
    this.initialAmount,
    this.currentAmount,
    this.buyNotification,
    this.suplier,
  );

  ChemicalMaterial.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString() == 'null' ? '' : json['id'],
        name = json['name'].toString() == 'null' ? '' : json['name'],
        CAS = json['CAS'].toString() == 'null' ? '' : json['iCAS'],
        type = json['type'].toString() == 'null' ? '' : json['type'],
        LMAId = json['LMAId'].toString() == 'null' ? '' : json['LMAId'],
        supervised = json['supervised'].toString() == 'null'
            ? false
            : json['supervised'],
        registrationDate = json['registrationDate'].toString() == 'null'
            ? Timestamp(0, 0)
            : Timestamp(json['calloutDate']['_seconds'],
                json['calloutDate']['_nanoseconds']),
        initialAmount = json['initialAmount'].toString() == 'null'
            ? 0.0
            : json['initialAmount'],
        currentAmount = json['currentAmount'].toString() == 'null'
            ? 0.0
            : json['currentAmount'],
        buyNotification = json['buyNotification'].toString() == 'null'
            ? 0.0
            : json['buyNotification'],
        suplier = json['suplier'].toString() == 'null' ? '' : json['suplier'];

  String getUnity() {
    switch (type) {
      case 'Solvente':
        return 'mL';
      case 'Reagente':
        return 'g';
      default:
        return 'un';
    }
  }
}
