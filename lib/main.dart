import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_links/app_links.dart';
import 'package:flutterweather/features/presentation/widget/Applife.dart';
import 'package:flutterweather/firebase_options.dart';
import 'package:flutterweather/injectionDependancy.dart';
import 'package:flutterweather/features/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutterweather/features/presentation/bloc/weatherbloc.dart';
import 'package:flutterweather/features/presentation/dashboard/dashboard_bloc.dart';
import 'package:flutterweather/features/data/datasource/firebase_messaging_service.dart';
import 'package:flutterweather/router/app_router.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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
        debugPrint(
          "Error showing local notification in background handler: $e",
        );
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

      final messagingService = getIt<FirebaseMessagingService>();
      await messagingService.initialize(requestPermissionOnInit: false);
      await initializeLocalNotifications();
    }
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    debugPrint("App started deep link");

    _initDeepLinks();
  }

  void _initDeepLinks() {
    debugPrint("App started deep link init");

    _appLinks
        .getInitialLink()
        .then((uri) {
          if (uri != null) {
            debugPrint('deep link initial uri: $uri');
            debugPrint('📱 Initial deep link received: $uri');
            _handleDeepLink(uri);
          } else {
            debugPrint('No initial deep link found');
          }
        })
        .catchError((error) {
          debugPrint('Error getting initial link: $error');
        });

    // Handle links when app is already running
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        debugPrint('deep link listen: $uri');

        _handleDeepLink(uri);
      },
      onError: (err) {
        debugPrint('Error listening to deep links: $err');
      },
      cancelOnError: false,
    );
  }

  void _handleDeepLink(Uri uri) {
    debugPrint('deep link handel');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final router = AppRouter.router;
      if (router == null) {
        debugPrint('❌ Router is null, cannot navigate');
        return;
      }

      try {
        // Extract path from deep link
        // Example: WeatherApp://weather -> /weather
        // Example: WeatherApp://open/weather -> /weather (host is "open", path is "/weather")
        // Example: WeatherApp://dashboard -> /dashboard
        // Example: WeatherApp:// -> /dashboard (default)
        String path = uri.path;
        String host = uri.host;

        // If host is "open" and path exists, use the path
        // Otherwise, if host is not empty and path is empty, use host as path
        if (host == 'open' && path.isNotEmpty) {
          // WeatherApp://open/weather -> use path "/weather"
          debugPrint('   Using path from host "open": $path');
        } else if (host.isNotEmpty && path.isEmpty) {
          // WeatherApp://weather -> use host "weather" as path
          path = host;
          debugPrint('   Using host as path: $path');
        }

        // Normalize path
        path = path.trim();
        if (path.isEmpty || path == '/') {
          path = '/dashboard'; // Default path
          debugPrint('   Using default path: $path');
        } else {
          // Ensure path starts with /
          if (!path.startsWith('/')) {
            path = '/$path';
          }
        }

        // Navigate to the path
        router.go(path);
      } catch (e, stackTrace) {
        debugPrint('Error handling deep link: $e');
        debugPrint('Stack trace: $stackTrace');
      }
    });
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<WeatherBloc>()),
        BlocProvider(create: (_) => getIt<DashboardBloc>()),
      ],
      child: Builder(
        builder: (context) {
          return AppLifecycleObserver(
            // child: WillPopScope(
            //   onWillPop: () async {
            //     debugPrint("The user close the app using Back button");
            //     return true;
            //   },
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Weather App',
              theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
              routerConfig: AppRouter.createRouter(context),
            ),
            //  ), for WillPopScope ..
          );
        },
      ),
    );
  }
}
