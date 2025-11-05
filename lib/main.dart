import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterweather/firebase_options.dart';
import 'package:flutterweather/injectionDependancy.dart';
import 'package:flutterweather/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutterweather/features/presentation/bloc/auth/auth_state.dart';
import 'package:flutterweather/features/presentation/bloc/weatherbloc.dart';
import 'package:flutterweather/features/presentation/pages/login_page.dart';
import 'package:flutterweather/features/presentation/pages/weather_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }
  
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<WeatherBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            // If authenticated, show weather page directly
            if (state is AuthAuthenticated) {
              return const WeatherPage();
            }
            // Show login page for AuthInitial, AuthUnauthenticated, or AuthLoading
            return const LoginPage();
          },
        ),
      ),
    );
  }
}

