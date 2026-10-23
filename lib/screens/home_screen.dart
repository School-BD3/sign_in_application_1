import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth_model.dart';
import '../models/profile_model.dart';
import 'edit_profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _logout(BuildContext context) {
    // Спочатку скидаємо дані профілю.
    context.read<ProfileModel>().resetProfile();

    // Потім завершуємо авторизацію.
    context.read<AuthModel>().logout();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('HomeScreen build');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Головна'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Вийти',
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.blue,
                ),

                const SizedBox(height: 24),

                // Оптимізоване відображення даних профілю.
                Column(
                  children: [
                    // Selector перебудовує лише ім'я.
                    Selector<ProfileModel, String>(
                      selector: (context, profile) =>
                          profile.name,
                      builder: (context, name, child) {
                        debugPrint(
                          'ProfileName Selector build',
                        );

                        return Text(
                          'Вітаємо, $name!',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    // Selector перебудовує лише email.
                    Selector<ProfileModel, String>(
                      selector: (context, profile) =>
                          profile.email,
                      builder: (context, email, child) {
                        debugPrint(
                          'ProfileEmail Selector build',
                        );

                        return Text(
                          email,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Consumer відображає стан авторизації.
                const AuthStatusWidget(),

                const SizedBox(height: 32),

                // Перехід до редагування профілю.
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) =>
                            const EditProfileScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text(
                    'Редагувати профіль',
                  ),
                ),

                const SizedBox(height: 16),

                // Вихід із застосунку.
                OutlinedButton.icon(
                  onPressed: () => _logout(context),
                  icon: const Icon(Icons.logout),
                  label: const Text('Вийти'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Окремий віджет для демонстрації Consumer.
class AuthStatusWidget extends StatelessWidget {
  const AuthStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(
      builder: (context, auth, child) {
        debugPrint('AuthStatus Consumer build');

        final isAuthenticated = auth.isAuthenticated;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isAuthenticated
                  ? Icons.check_circle
                  : Icons.cancel,
              color: isAuthenticated
                  ? Colors.green
                  : Colors.red,
              size: 20,
            ),

            const SizedBox(width: 8),

            Flexible(
              child: Text(
                isAuthenticated
                    ? 'Користувач авторизований'
                    : 'Користувач не авторизований',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: isAuthenticated
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
