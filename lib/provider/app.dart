import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier {
  bool isLoading = false;
  changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
