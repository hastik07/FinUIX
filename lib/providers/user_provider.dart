import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _userName = 'Hastik Mangukiya';
  String _userType = 'Premium Member';

  String get userName => _userName;
  String get userType => _userType;

  void updateUserName(String newName) {
    if (newName.trim().isNotEmpty) {
      _userName = newName;
      notifyListeners();
    }
  }

  void updateUserType(String newType) {
    if (newType.trim().isNotEmpty) {
      _userType = newType;
      notifyListeners();
    }
  }
}
