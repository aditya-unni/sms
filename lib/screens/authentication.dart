import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sms/provider/app.dart';
import 'package:sms/provider/googleauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sms/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sms/models/user.dart';
import 'package:sms/services/user.dart';

import 'home.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with ChangeNotifier {
  late User _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();

  late UserModel _userModel;

  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;

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

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(children: [
                TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(hintText: 'Enter your email here'),
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      hintText: 'Enter your password here'),
                ),
                TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      final usercredential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: password)
                          .then((userCredentials) async {
                        _user = userCredentials.user!;
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString("id", _user.uid);
                        if (!await _userServices.doesUserExist(_user.uid)) {
                          _userServices.createUser(
                              id: _user.uid, role: "default");
                          await initialsizeUserModel();
                        } else {
                          await initialsizeUserModel();
                        }
                      });
                      print(usercredential);

                      Get.to(HomeScreen());
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("User not found")));
                      } else if (e.code == 'wrong-password') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Wrong password")));
                      }
                    } on Exception catch (e) {
                      print('Something bad happened');
                      print(e.runtimeType);
                      print(e);
                    }
                  },
                  child: const Text('Login'),
                ),
              ]);
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
