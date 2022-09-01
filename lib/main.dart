// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sms/controllers/menu_controller.dart';
import 'package:sms/controllers/navigation_controller.dart';
import 'package:sms/helper/constants.dart';
import 'package:sms/layout.dart';

import 'package:sms/provider/app.dart';
import 'package:sms/provider/auth.dart';
import 'package:sms/provider/resident.dart';
import 'package:sms/routing/routes.dart';

import 'package:sms/screens/authentication.dart';
import 'package:sms/screens/home.dart';

//loading screen
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization;
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AppProvider(),
        ),
        ChangeNotifierProvider.value(value: AuthProvider.init()),
        ChangeNotifierProvider.value(value: ResProvider.init())
      ],
      child: GetMaterialApp(
        initialRoute: rootRoute,
        unknownRoute: GetPage(
            name: '/not-found',
            page: () => Text("Notfound"),
            transition: Transition.fadeIn),
        getPages: [
          GetPage(
              name: rootRoute,
              page: () {
                return AppScreensController();
              }),
          // GetPage(name: authenticationPageRoute, page: () => LoginView()),
        ],
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
        home: AppScreensController(),
      ),
    );
  }
}

class AppScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.Uninitialized:
        return SpinKitFadingCircle(
          color: Colors.blue,
          size: 50.0,
        );
      case Status.Unauthenticated:
        return LoginView();
      case Status.Authenticating:
        return SpinKitFadingCircle(
          color: Colors.blue,
          size: 50.0,
        );
      case Status.Authenticated:
        return SiteLayout();
      default:
        return LoginView();
    }
  }
}
