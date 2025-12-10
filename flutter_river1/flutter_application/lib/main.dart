import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'presentation/screens/home_screen.dart';
import 'presentation/screens/refresh_invalidate_example_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Switch between screens here:
      home:
          const RefreshInvalidateExampleScreen(), // Currently showing Refresh/Invalidate example
      // home: const HomeScreen(), // Uncomment to show Products screen
    );
  }
}
