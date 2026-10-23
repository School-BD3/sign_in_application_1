import 'package:flutter/foundation.dart';
import '../services/fake_auth_api.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  error,
}

class AuthModel extends ChangeNotifier {
  final FakeAuthApi _api = FakeAuthApi();

  AuthStatus _status = AuthStatus.initial;
  String? _errorMessage;
  String? _userName;

  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;
  String? get userName => _userName;

  bool get isAuthenticated =>
      _status == AuthStatus.authenticated;

  bool get isLoading => _status == AuthStatus.loading;

  Future<void> login(String email, String password) async {
    if (isLoading) return;

    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final name = await _api.login(email, password);

      _userName = name;
      _status = AuthStatus.authenticated;
    } catch (error) {
      _userName = null;
      _errorMessage = error.toString().replaceFirst(
        'Exception: ',
        '',
      );
      _status = AuthStatus.error;
    }

    notifyListeners();
  }

  void logout() {
    _userName = null;
    _errorMessage = null;
    _status = AuthStatus.initial;

    notifyListeners();
  }
}
