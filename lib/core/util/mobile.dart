import 'package:flutter/material.dart';

class Mobile extends StatelessWidget {
  const Mobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mobileSize = MediaQuery.of(context);
    return Scaffold(backgroundColor: const Color.fromARGB(255, 86, 139, 255));
  }
}
