import 'package:flutter/material.dart';
import 'package:sms/helper/responsiveness.dart';
import 'package:sms/widgets/large_screen.dart';
import 'package:sms/helper/local_navigator.dart';
import 'package:sms/widgets/side_menu.dart';
import 'package:sms/widgets/small_screen.dart';

import 'widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
        child: localNavigator(),
      ),
    );
  }
}
