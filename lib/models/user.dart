import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "id";
  static const ROLE = "role";

  late String _id;
  late String _role;

  //getters
  String get id => _id;
  String get role => _role;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = (snapshot.data() as dynamic)[ID];
    _role = (snapshot.data() as dynamic)[ROLE];
  }
}
