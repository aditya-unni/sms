import 'package:flutter/material.dart';
import 'package:sms/constants/style.dart';
import 'package:sms/routing/routes.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = overviewPageDisplayName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case overviewPageDisplayName:
        return _customIcon(Icons.trending_up, itemName);
      case residentsPageDisplayName:
        return _customIcon(Icons.group, itemName);
      case propertiesPageDisplayName:
        return _customIcon(Icons.home, itemName);
      case staffsPageDisplayName:
        return _customIcon(Icons.handyman, itemName);
      case authenticationPageDisplayName:
        return _customIcon(Icons.exit_to_app, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22, color: dark);

    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
