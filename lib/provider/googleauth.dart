import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:sms/helper/constants.dart';
import 'package:sms/models/user.dart';
import 'package:sms/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  late User _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();

  late UserModel _userModel;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;
  AuthProvider.init() {
    _fireSetUp();
  }

  void _fireSetUp() async {
    await initialization.then((value) {
      auth.authStateChanges().listen(_onStateChanged);
    });
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        _user = userCredential.user!;
      } catch (e) {
        print(e);
      }
    }
    try {
      final GoogleSignInAccount? googleuser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleuser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await auth.signInWithCredential(credential).then((userCredentials) async {
        _user = userCredentials.user!;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("id", _user.uid);
        if (!await _userServices.doesUserExist(_user.uid)) {
          _userServices.createUser(id: _user.uid, role: "default");
          await initialsizeUserModel();
        } else {
          await initialsizeUserModel();
        }
      });
      return {'success': true, 'message': 'success'};
    } catch (e) {
      notifyListeners();
      return {'success': true, 'message': e.toString()};
    }
  }

  Future<bool> initialsizeUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? _userId = preferences.getString('id');
    _userModel = await _userServices.getUserById(_userId!);
    notifyListeners();
    if (_userModel == null) {
      return false;
    } else {
      return true;
    }
  }

  Future signOut() async {
    auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  _onStateChanged(User? firebaseuser) async {
    if (firebaseuser == null) {
      _status = Status.Unauthenticated;
      notifyListeners();
    } else {
      _user = firebaseuser;
      initialsizeUserModel();
      Future.delayed(const Duration(seconds: 2), () {
        _status = Status.Authenticated;
        notifyListeners();
      });
    }
  }
}
