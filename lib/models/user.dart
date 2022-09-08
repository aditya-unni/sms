import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const PHOTO = "photo";
  static const ROLE = "role";

  late String _id;
  late String _name;
  late String _photo;
  late String _role;

  //getters
  String get id => _id;
  String get name => _name;
  String get photo => _photo;
  String get role => _role;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = (snapshot.data() as dynamic)[ID];
    _name = (snapshot.data() as dynamic)[NAME];
    _photo = (snapshot.data() as dynamic)[PHOTO];
    _role = (snapshot.data() as dynamic)[ROLE];
  }
}
