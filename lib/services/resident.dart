//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/helper/constants.dart';
import 'package:sms/models/resident.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sms/services/user.dart';

class ResidentServices {
  String collection = "residents";
  final UserServices userServices = UserServices();
  Future<Map<String, dynamic>> createResident({
    String name,
    String address,
    int contact,
    String email,
    String password,
  }) async {
    try {
      FirebaseApp app = await Firebase.initializeApp(
          name: 'secondary', options: Firebase.app().options);
      await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(((value) => {
                firebaseFirestore
                    .collection(collection)
                    .doc(value.user.uid)
                    .set({
                  "id": value.user.uid,
                  "name": name,
                  "address": address,
                  "contact": contact,
                  "email": email,
                }),
                userServices.createUser(
                    id: value.user.uid, name: name, role: "residents")
              }));
      app.delete();
      return {'success': true, 'message': 'success'};
    } on FirebaseAuthException catch (e) {
      return {'success': false, 'message': e.code};
    } catch (e) {
      print(e);
    }
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
  Future<String> getNumberofRes() async {
    List<ResidentModel> _resList = await getAll();
    return "${_resList.length}";
  }
}
