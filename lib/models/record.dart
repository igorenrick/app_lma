import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Record {
  late String id;
  final String CAS;
  final String materialId;
  final Timestamp recordDate;
  final double amount;
  final String type;
  final String userId;

  Record(
    this.CAS,
    this.materialId,
    this.recordDate,
    this.amount,
    this.type,
    this.userId,
  );

  Record.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString() == 'null' ? '' : json['id'],
        CAS = json['CAS'].toString() == 'null' ? '' : json['CAS'],
        materialId =
            json['materialId'].toString() == 'null' ? '' : json['materialId'],
        recordDate = json['recordDate'].toString() == 'null'
            ? Timestamp(0, 0)
            : json['recordDate'],
        amount = json['amount'].toString() == 'null'
            ? 0.0
            : json['amount'].toDouble(),
        type = json['type'].toString() == 'null' ? '' : json['type'],
        userId = json['userId'].toString() == 'null' ? '' : json['userId'];

  Future<String> formatDate() async {
    String date = '';
    await initializeDateFormatting('pt_BR', null).then((_) {
      date = DateFormat.yMd('pt_BR').format(recordDate.toDate());
    });
    return date;
  }
}
