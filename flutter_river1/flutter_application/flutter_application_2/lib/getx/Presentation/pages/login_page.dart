import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

import 'package:get/get.dart';
import 'meal_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                AuthController.instance.signInWithGoogle();
              },
              icon: const Icon(Icons.login),
              label: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                Get.to(() => const MealPage());
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
