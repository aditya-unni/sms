import 'package:flutter/cupertino.dart';
import 'package:sms/constants/controllers.dart';
import 'package:sms/routing/router.dart';
import 'package:sms/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: overviewPageRoute,
    );
