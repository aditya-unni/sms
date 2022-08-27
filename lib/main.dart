import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sms/helper/constants.dart';
import 'package:sms/provider/app.dart';
import 'package:sms/provider/googleauth.dart';
import 'package:sms/screens/authentication.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AppProvider(),
        ),
        ChangeNotifierProvider.value(value: AuthProvider.init()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Dash",
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.black),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            }),
            primaryColor: Colors.blue),
        home: LoginView(),
      ),
    );
  }
}
