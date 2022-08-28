import 'package:flutter/material.dart';
//get
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
//provider
import 'package:provider/provider.dart';
import 'package:sms/provider/app.dart';
import 'package:sms/provider/auth.dart';
//firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sms/firebase_options.dart';
//dp
import 'package:shared_preferences/shared_preferences.dart';
//models
import 'package:sms/models/user.dart';
import 'package:sms/screens/admin_view.dart';
//services
import 'package:sms/services/user.dart';
//screens
import 'home.dart';
import 'package:sms/screens/resident_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with ChangeNotifier {
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
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final AppProvider appProvider = Provider.of<AppProvider>(context);
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
                      Map result =
                          await authProvider.signInWithCred(email, password);
                      if (result['success']) {
                        if (result['role'] == "resident") {
                          Get.to(ResidentView());
                        } else if (result['role'] == "admin") {
                          Get.to(AdminView());
                        } else {
                          Get.to(HomeScreen());
                        }
                      }
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
