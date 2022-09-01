import 'package:flutter/material.dart';
import 'package:sms/helper/responsiveness.dart';
import 'package:sms/constants/controllers.dart';
// import 'package:sms/pages/admin/overview/widgets/available_drivers_table.dart';
import 'package:sms/pages/admin/overview/widgets/overview_cards_large.dart';
import 'package:sms/pages/admin/overview/widgets/overview_cards_medium.dart';
import 'package:sms/pages/admin/overview/widgets/overview_cards_small.dart';
import 'package:sms/pages/admin/overview/widgets/revenue_section_large.dart';

import 'package:sms/widgets/custom_text.dart';
import 'package:get/get.dart';

import 'widgets/revenue_section_small.dart';

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 86 : 6,
                        left: ResponsiveWidget.isSmallScreen(context) ? 26 : 0),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              if (ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isMediumScreen(context))
                if (ResponsiveWidget.isCustomSize(context))
                  OverviewCardsMediumScreen()
                else
                  OverviewCardsLargeScreen()
              else
                OverviewCardsSmallScreen(),
              if (!ResponsiveWidget.isSmallScreen(context))
                RevenueSectionLarge()
              else
                RevenueSectionSmall(),

              //   AvailableDriversTable(),
            ],
          ))
        ],
      ),
    );
  }
}
