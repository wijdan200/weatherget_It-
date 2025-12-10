import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashAnimated extends StatefulWidget {
  const SplashAnimated({super.key});

  @override
  State<SplashAnimated> createState() => _SplashAnimatedState();
}

class _SplashAnimatedState extends State<SplashAnimated>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Remove native splash screen immediately when this widget mounts
    print("CLK splash page");

    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF89CFF0), // Baby blue color
      body: Stack(children: [
        ],
      ),
    );
  }
}
