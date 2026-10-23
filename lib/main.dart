import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/auth_model.dart';
import 'models/profile_model.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Авторизація та профіль',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('AuthWrapper build');

    final isAuthenticated =
        context.select<AuthModel, bool>(
          (auth) => auth.isAuthenticated,
        );

    if (isAuthenticated) {
      return const HomeScreen();
    }

    return const LoginScreen();
  }
}
