import 'package:cloud_firestore/cloud_firestore.dart';

class ResidentModel {
  static const ID = "id";
  static const NAME = "name";
  static const ADDRESS = "address";
  static const CONTACT = "contact";
  static const EMAIL = "email";

  late String _id;
  late String _name;
  late String _address;
  late int _contact;
  late String _email;

  //getters
  String get id => _id;
  String get name => _name;
  String get address => _address;
  int get contact => _contact;
  String get email => _email;

  ResidentModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = (snapshot.data() as dynamic)[ID];
    _name = (snapshot.data() as dynamic)[NAME];
    _address = (snapshot.data() as dynamic)[ADDRESS];
    _contact = (snapshot.data() as dynamic)[CONTACT];
    _email = (snapshot.data() as dynamic)[EMAIL];
  }
}
