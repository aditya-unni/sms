//@dart=2.9
import 'package:sms/helper/constants.dart';
import 'package:sms/models/resident.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResidentServices {
  String collection = "residents";
  void createResident({
    String id,
    String name,
    String address,
    int contact,
    String email,
  }) {
    firebaseFirestore.collection(collection).doc(id).set({
      "id": id,
      "name": name,
      "address": address,
      "contact": contact,
      "email": email,
    });
  }

  Future<ResidentModel> getResidentById(String id) =>
      firebaseFirestore.collection(collection).doc(id).get().then((doc) {
        return ResidentModel.fromSnapshot(doc);
      });

  Future<bool> doesResidentExist(String id) async => firebaseFirestore
      .collection(collection)
      .doc(id)
      .get()
      .then((value) => value.exists);

  Future<List<ResidentModel>> getAll() async =>
      firebaseFirestore.collection(collection).get().then((result) {
        List<ResidentModel> users = [];
        for (DocumentSnapshot user in result.docs) {
          users.add(ResidentModel.fromSnapshot(user));
        }
        return users;
      });
}
