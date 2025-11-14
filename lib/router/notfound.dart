import 'package:flutter/material.dart';

class Notfound extends StatefulWidget {
  const Notfound({super.key});

  @override
  State<Notfound> createState() => _NotfoundState();
}

class _NotfoundState extends State<Notfound>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Page Not Found "))
     
    );
  }
}