import 'package:flutter/material.dart';

import 'package:sms/pages/admin/properties/properties.dart';
import 'package:sms/pages/admin/residents/residents.dart';
import 'package:sms/pages/admin/overview/overview.dart';
import 'package:sms/pages/admin/staffs/staffs.dart';
import 'package:sms/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case residentsPageRoute:
      return _getPageRoute(ResidentsPage());
    case propertiesPageRoute:
      return _getPageRoute(PropertiesPage());
    case staffsPageRoute:
      return _getPageRoute(StaffsPage());
    default:
      return _getPageRoute(OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}