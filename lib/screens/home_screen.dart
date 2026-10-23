import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth_model.dart';
import '../models/profile_model.dart';
import 'edit_profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            onPressed: () {
              context.read<AuthModel>().logout();
              context.read<ProfileModel>().resetProfile();
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.blue,
                ),
                const SizedBox(height: 24),

                
                Column(
                  children: [
                    Selector<ProfileModel, String>(
                      selector: (context, profile) => profile.name,
                      builder: (context, name, child) {
                        debugPrint('ProfileName Selector build');

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

                    Selector<ProfileModel, String>(
                      selector: (context, profile) => profile.email,
                      builder: (context, email, child) {
                        debugPrint('ProfileEmail Selector build');

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


                const SizedBox(height: 32),

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
                  label: const Text('Редагувати профіль'),
                ),

                const SizedBox(height: 16),

                OutlinedButton.icon(
                  onPressed: () {
                    context.read<AuthModel>().logout();
                    context.read<ProfileModel>().resetProfile();
                  },
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
