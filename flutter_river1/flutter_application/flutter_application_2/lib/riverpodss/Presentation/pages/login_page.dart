import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/auth_controller.dart';
import 'meal_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to auth state changes to navigate
    ref.listen<User?>(authControllerProvider, (previous, next) {
      if (next != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MealPage()),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color.fromARGB(255, 193, 167, 201),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                ref.read(authControllerProvider.notifier).signInWithGoogle();
              },
              icon: const Icon(Icons.login),
              label: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MealPage()),
                );
              },
              icon: const Icon(Icons.restaurant_menu),
              label: const Text('Skip Login'),
            ),
          ],
        ),
      ),
    );
  }
}
