import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutterweather/firebase_options.dart';
import 'package:flutterweather/injectionDependancy.dart';
import 'package:flutterweather/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutterweather/features/presentation/bloc/weatherbloc.dart';
import 'package:flutterweather/features/presentation/dashboard/dashboard_bloc.dart';
import 'package:flutterweather/features/data/datasource/firebase_messaging_service.dart';
import 'package:flutterweather/router/app_router.dart';
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Skip on web - background messages not supported
  if (kIsWeb) {
    debugPrint("Background message handler not supported on web");
    return;
  }
  
  try {
    await Firebase.initializeApp();
    debugPrint("Background message received: ${message.messageId}");
    debugPrint("Message data: ${message.data}");
    debugPrint("Message notification: ${message.notification?.title}");
    
    // Show local notification for background messages
    // Import the function explicitly for background isolate
    if (message.notification != null) {
      try {
        await showLocalNotification(message);
      } catch (e) {
        debugPrint("Error showing local notification in background handler: $e");
      }
    }
  } catch (e, stackTrace) {
    debugPrint("Error in background message handler: $e");
    debugPrint("Stack trace: $stackTrace");
  }
}

// Global navigator key for navigation from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  setup();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    // Set up background message handler (only for mobile platforms)
    if (!kIsWeb) {
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      
      // Initialize Firebase Messaging (without requesting permission - will be requested after login)
      final messagingService = getIt<FirebaseMessagingService>();
      await messagingService.initialize(requestPermissionOnInit: false);
      await initializeLocalNotifications(); 
    }
    
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }
  
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
        BlocProvider(
          create: (_) => getIt<DashboardBloc>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Weather App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              useMaterial3: true,
            ),
            routerConfig: AppRouter.createRouter(context),
          );
        },
      ),
    );
  }
}
