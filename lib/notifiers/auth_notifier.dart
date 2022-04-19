import 'package:flutter/cupertino.dart';

class AuthNotifier extends ChangeNotifier {
  bool _showLPassword = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _showNPassword = false;
  bool _showNCPassword = false;

  bool get showLPassword => _showLPassword;
  bool get showPassword => _showPassword;
  bool get showConfirmPassword => _showConfirmPassword;
  bool get showNPassword => _showNPassword;
  bool get showNCPassword => _showNCPassword;

  set showLPassword(value) {
    _showLPassword = value;
    notifyListeners();
  }

  set showPassword(value) {
    _showPassword = value;
    notifyListeners();
  }

  set showConfirmPassword(value) {
    _showConfirmPassword = value;
    notifyListeners();
  }

  set showNPassword(value) {
    _showNPassword = value;
    notifyListeners();
  }

  set showNCPassword(value) {
    _showNCPassword = value;
    notifyListeners();
  }
}
