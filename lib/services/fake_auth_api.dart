import 'dart:async';
import 'dart:math';

class FakeAuthApi {
  final Random _random = Random();

  Future<String> login(String email, String password) async {
    await Future<void>.delayed(
      Duration(seconds: 1 + _random.nextInt(2)),
    );

    if (_random.nextInt(5) == 0) {
      throw Exception('Сервер недоступний');
    }

    if (email == 'student@example.com' && password == 'password123') {
      return 'Студент';
    }

    throw Exception('Невірний email або пароль');
  }
}
