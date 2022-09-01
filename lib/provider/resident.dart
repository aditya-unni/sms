//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:sms/models/resident.dart';
import 'package:sms/services/resident.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../helper/constants.dart';

class ResProvider with ChangeNotifier {
  User _user;
  ResidentServices _residentServices = ResidentServices();
  ResidentModel _residentModel;
  List<ResidentModel> _resList;
  int number;

  ResidentModel get residentModel => _residentModel;
  User get user => _user;

  ResProvider.init() {
    _firestup();
  }

  _firestup() async {
    await initialization.then((value) {
      auth.authStateChanges();
    });
  }

  Future<String> getNumberofRes() async {
    _resList = await _residentServices.getAll();
    number = _resList.length;
    notifyListeners();
    return "$number";
  }

  Future<List<ResidentModel>> getAllRes() async {
    _resList = await _residentServices.getAll();
    notifyListeners();
    return _resList;
  }
}
