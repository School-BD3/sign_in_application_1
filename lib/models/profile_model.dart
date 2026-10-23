import 'package:flutter/foundation.dart';

class ProfileModel extends ChangeNotifier {
  String _name = 'Студент';
  String _email = 'student@example.com';

  String get name => _name;
  String get email => _email;

  void updateProfile({
    required String name,
    required String email,
  }) {
    if (_name == name && _email == email) return;

    _name = name;
    _email = email;

    notifyListeners();
  }

  void resetProfile() {
    _name = 'Студент';
    _email = 'student@example.com';

    notifyListeners();
  }
}
