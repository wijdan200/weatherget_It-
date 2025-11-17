






// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// class DeepLinkTestPage extends StatelessWidget {
//   const DeepLinkTestPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Deep Link Test')),
//       body: Center(
//         child:  ElevatedButton(onPressed: () async {
//     final Uri uri = Uri.parse('WeatherApp://open');

//     if (await canLaunchUrl(uri)) {
//       await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication,
//       );
//     } else {
//       debugPrint('Cannot launch URI');
//     }
//   },
//           child: const Text('Test Deep Link'),
//         ),
//       ),
//     );
//   }
// }
