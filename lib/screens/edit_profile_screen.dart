import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/profile_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    final profile = context.read<ProfileModel>();

    _nameController = TextEditingController(
      text: profile.name,
    );

    _emailController = TextEditingController(
      text: profile.email,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<ProfileModel>().updateProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('EditProfileScreen build');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Редагування профілю'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.manage_accounts,
                    size: 90,
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 24),

                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Ім'я",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return "Введіть ім'я";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final email = value?.trim() ?? '';

                      if (email.isEmpty) {
                        return 'Введіть email';
                      }

                      final emailRegex = RegExp(
                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                      );

                      if (!emailRegex.hasMatch(email)) {
                        return 'Некоректний формат email';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  ElevatedButton.icon(
                    onPressed: _saveProfile,
                    icon: const Icon(Icons.save),
                    label: const Text('Зберегти зміни'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
