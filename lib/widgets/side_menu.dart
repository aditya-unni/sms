// @dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/constants/controllers.dart';
import 'package:sms/constants/style.dart';
import 'package:sms/helper/responsiveness.dart';
import 'package:sms/provider/auth.dart';
import 'package:sms/routing/routes.dart';
import 'package:sms/widgets/custom_text.dart';
import 'package:sms/widgets/side_menu_items.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: _width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "Dashboard",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      ),
                    ),
                    SizedBox(width: _width / 48),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenuItemRoutes
                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () async {
                      if (menuController
                          .isActive(authenticationPageDisplayName)) {
                        menuController
                            .changeActiveItemTo(overviewPageDisplayName);
                        navigationController.navigateTo(overviewPageRoute);
                      }

                      if (!menuController.isActive(item.name)) {
                        menuController.changeActiveItemTo(item.name);
                        if (_width < mediumScreenSize) Get.back();
                        navigationController.navigateTo(item.route);
                      }
                      if (item.route == authenticationPageRoute) {
                        Get.offAllNamed(authenticationPageRoute);
                        menuController
                            .changeActiveItemTo(overviewPageDisplayName);
                        await authProvider.signOut();
                      }
                    }))
                .toList(),
          )
        ],
      ),
    );
  }
}
