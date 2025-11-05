// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterweather/main.dart';
import 'package:flutterweather/firebase_options.dart';
import 'package:flutterweather/injectionDependancy.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase for testing
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize dependency injection
  setup();

  testWidgets('App starts and shows login page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that login page is shown (for unauthenticated users)
    expect(find.text('Weather App'), findsOneWidget);
  });
}
