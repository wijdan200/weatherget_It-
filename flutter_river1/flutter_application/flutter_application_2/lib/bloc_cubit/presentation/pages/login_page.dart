import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_2/bloc_cubit/presentation/pages/meal_page.dart';
import 'package:flutter_application_2/bloc_cubit/presentation/cubit/meal_cubit.dart';
import 'package:flutter_application_2/bloc_cubit/injection_container.dart'
    as di;

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
                // TODO: Implement Google Sign-In
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Google Sign-In not implemented yet')),
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (_) => di.sl<MealCubit>()..searchMeals('chicken'),
                      child: const MealPage(),
                    ),
                  ),
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
