import 'package:cloud_firestore/cloud_firestore.dart';

class ChemicalMaterial {
  final String id;
  final String name;
  final String CAS;
  final String type;
  final String LMAId;
  final String supervised;
  final Timestamp registrationDate;
  final int initialAmount;
  final int currentAmount;
  final int buyNotification;
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
}
