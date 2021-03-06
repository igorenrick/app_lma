import 'package:cloud_firestore/cloud_firestore.dart';

class LMAUser {
  late String id;
  late String authId;
  final String registration;
  late String email;
  final String name;
  final String surname;
  final bool enabled;
  final String attribution;
  final Timestamp createdAt;
  late String token;

  LMAUser(
    this.id,
    this.authId,
    this.registration,
    this.name,
    this.surname,
    this.enabled,
    this.attribution,
    this.createdAt,
  );

  LMAUser.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString() == 'null' ? '' : json['id'],
        authId = json['authId'].toString() == 'null' ? '' : json['authId'],
        registration = json['registration'].toString() == 'null'
            ? ''
            : json['registration'],
        name = json['name'].toString() == 'null' ? '' : json['name'],
        surname = json['surname'].toString() == 'null' ? '' : json['surname'],
        enabled =
            json['enabled'].toString() == 'null' ? false : json['enabled'],
        attribution =
            json['attribution'].toString() == 'null' ? '' : json['attribution'],
        createdAt = json['createdAt'].toString() == 'null'
            ? Timestamp(0, 0)
            : json['createdAt'];

  String getFullName() {
    return '$name $surname';
  }
}
