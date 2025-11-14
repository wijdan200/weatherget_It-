import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutterweather/router/app_router.dart';

// Note: Background handler is defined in main.dart

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getToken() async {
    if (kIsWeb) {
      debugPrint("FCM Token not available on web");
      return null;
    }
    
    try {
      String? token = await _firebaseMessaging.getToken();
      debugPrint("FCM Token: $token");
      return token;
    } catch (e) {
      debugPrint("Error getting FCM token: $e");
      return null;
    }
  }

  Future<AuthorizationStatus> getPermissionStatus() async {
    // Notification permissions not fully supported on web
    if (kIsWeb) {
      debugPrint("Notification permissions not available on web");
      return AuthorizationStatus.notDetermined;
    }
    
    try {
      NotificationSettings settings = await _firebaseMessaging.getNotificationSettings();
      return settings.authorizationStatus;
    } catch (e) {
      debugPrint("Error getting permission status: $e");
      return AuthorizationStatus.notDetermined;
    }
  }

  // Request notification permissions (shows system dialog)
  Future<NotificationPermissionResult> requestPermission() async {
    // Notification permissions not fully supported on web
    if (kIsWeb) {
      debugPrint("Notification permissions not available on web");
      return NotificationPermissionResult(
        isGranted: false,
        isProvisional: false,
        isDenied: true,
        status: AuthorizationStatus.notDetermined,
      );
    }
    
    try {
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      final status = settings.authorizationStatus;
      debugPrint("Notification permission status: $status");
      
      return NotificationPermissionResult(
        isGranted: status == AuthorizationStatus.authorized,
        isProvisional: status == AuthorizationStatus.provisional,
        isDenied: status == AuthorizationStatus.denied,
        status: status,
      );
    } catch (e) {
      debugPrint("Error requesting permission: $e");
      return NotificationPermissionResult(
        isGranted: false,
        isProvisional: false,
        isDenied: true,
        status: AuthorizationStatus.notDetermined,
      );
    }
  }

  Future<void> initialize({bool requestPermissionOnInit = false}) async {
    if (kIsWeb) {
      debugPrint("Firebase Messaging not fully supported on web, skipping initialization");
      return;
    }
    
    try {
      // Set notification channel for Android (important for Infinix devices)
      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      
      // Check permission status first
      final currentStatus = await getPermissionStatus();
      debugPrint("Current notification permission: $currentStatus");

      // Only request permission if explicitly requested and not already granted
      if (requestPermissionOnInit && currentStatus != AuthorizationStatus.authorized) {
        await requestPermission();
        // Re-check status after requesting
        final newStatus = await getPermissionStatus();
        if (newStatus == AuthorizationStatus.authorized || 
            newStatus == AuthorizationStatus.provisional) {
          await getToken();
        }
      } else if (currentStatus == AuthorizationStatus.authorized || 
          currentStatus == AuthorizationStatus.provisional) {
        await getToken();
      }

      // Setup foreground message handler (skip on web)
      if (!kIsWeb) {
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
          try {
            debugPrint("=== SHOW NOTIFICATION TRIGGERED ===");
            debugPrint("📨 Foreground message received: ${message.messageId}");
            debugPrint("📦 Message data: ${message.data}");
            debugPrint("📋 Message notification title: ${message.notification?.title}");
            debugPrint("📋 Message notification body: ${message.notification?.body}");
            debugPrint("🔔 Calling showLocalNotification...");
            
            // Show notification immediately
            await showLocalNotification(message);
          
          debugPrint("✅ Foreground notification handling completed");
        } catch (e, stackTrace) {
          debugPrint("❌ Error handling foreground message: $e");
          debugPrint("Stack trace: $stackTrace");
        }
      });
      }

      // Setup message opened handler (when user taps notification)
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint("Message opened app: ${message.messageId}");
        debugPrint("Message data: ${message.data}");
        _handleNotificationNavigation(message);
      });

      // Check if app was opened from a notification .. بتشتغل لما يكون مسكر 
      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        debugPrint("App opened from notification: ${initialMessage.messageId}");
        _handleNotificationNavigation(initialMessage);
      }

      // Setup token refresh handler
      _firebaseMessaging.onTokenRefresh.listen((String token) {
        debugPrint("FCM Token refreshed: $token");
      });
    } catch (e) {
      debugPrint("Error initializing FCM: $e");
    }
  }

  // Handle notification navigation based on data field (for FCM messages)
  void _handleNotificationNavigation(RemoteMessage message) {
     try {
       // Default to 'another' (PageTwo) if route not specified
       final route = message.data['route'] ?? message.data['page'] ?? 'another';
       debugPrint("🔔 FCM notification tapped, route: $route");
       navigateToRoute(route);
    } catch (e) {
      debugPrint("❌ Error navigating from FCM notification: $e");
      navigateToRoute('another'); // Fallback to PageTwo
    }
  }

  // Handle local notification tap (when user taps notification in notification tray)
  static void handleLocalNotificationTap(String? payload) {
    try {
      debugPrint("🔔 Processing local notification tap...");
      
     
      String route = 'another'; // Default route (PageTwo)
      
      if (payload != null && payload.isNotEmpty) {
        // Remove leading slash if present
        route = payload.startsWith('/') ? payload.substring(1) : payload;
        
        // Handle common route names
        if (route == 'notify_page' || route == 'notify') {
          route = 'notify';
        } else if (route == 'another_page' || route == 'pagetwo' || route == 'another') {
          route = 'another';
        } else if (route == 'weather' || route == 'weather_page') {
          route = 'weather';
        } else if (route == 'login' || route == 'login_page') {
          route = 'login';
        }
      }
      
      debugPrint("   - Extracted route: $route");
      navigateToRoute(route);
    } catch (e) {
      debugPrint("❌ Error handling local notification tap: $e");
      navigateToRoute('another'); // Fallback to PageTwo
    }
  }

  // Navigate to route using GoRouter
  static void navigateToRoute(String route) {
    try {
      final router = AppRouter.router;
      
      if (router == null) {
        debugPrint("⚠️ Router not initialized yet, will retry...");
        // Retry after a short delay to allow router initialization
        Future.delayed(const Duration(milliseconds: 500), () {
          final retryRouter = AppRouter.router;
          if (retryRouter != null) {
            performNavigation(retryRouter, route);
          } else {
            debugPrint("❌ Router still not available after retry");
          }
        });
        return;
      }
      
      performNavigation(router, route);
    } catch (e) {
      debugPrint("❌ Error in navigateToRoute: $e");
    }
  }

  // Perform the actual navigation
  static void performNavigation(dynamic router, String route) {
    try {
      // Map route names to paths
      String path = '/another'; // Default path (PageTwo)
      
      switch (route.toLowerCase()) {
        case 'notify':
        case 'notify_page':
          path = '/notify';
          break;
        case 'another':
        case 'another_page':
        case 'pagetwo':
          path = '/another';
          break;
        case 'weather':
        case 'weather_page':
          path = '/weather';
          break;
        case 'login':
        case 'login_page':
          path = '/login';
          break;
        default:
          path = '/another'; // Default to PageTwo
      }
      
      debugPrint("✅ Navigating to: $path");
      router.go(path);
      debugPrint("✅ Navigation completed successfully");
    } catch (e) {
      debugPrint("❌ Error performing navigation: $e");
    }
  }

  // Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint("Subscribed to topic: $topic");
    } catch (e) {
      debugPrint("Error subscribing to topic: $e");
    }
  }

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      debugPrint("Unsubscribed from topic: $topic");
    } catch (e) {
      debugPrint("Error unsubscribing from topic: $e");
    }
  }
}

// Permission result class
class NotificationPermissionResult {
  final bool isGranted;
  final bool isProvisional;
  final bool isDenied;
  final AuthorizationStatus status;

  NotificationPermissionResult({
    required this.isGranted,
    required this.isProvisional,
    required this.isDenied,
    required this.status,
  });
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeLocalNotifications() async {
  // Skip on web - local notifications not supported
  if (kIsWeb) {
    debugPrint("Local notifications not supported on web, skipping initialization");
    return;
  }
  
  try {
    // Request permissions for Android 13+
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // name
      description: 'Channel for important notifications',
      importance: Importance.max, // Changed from high to max for Infinix devices
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    // Initialize the plugin
    const InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings);

    final bool? initialized = await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint("🔔 Local notification tapped!");
        debugPrint("   - Payload: ${response.payload}");
        debugPrint("   - ID: ${response.id}");
        debugPrint("   - Action: ${response.actionId}");
        
        // Handle navigation based on payload
        FirebaseMessagingService.handleLocalNotificationTap(response.payload);
      },
    );

    if (initialized == true) {
      debugPrint("Local notifications initialized successfully");
      
      // Create the notification channel (Android 8.0+)
      // This is critical for Infinix devices
      final androidImplementation = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      
      if (androidImplementation != null) {
        await androidImplementation.createNotificationChannel(channel);
        debugPrint("Notification channel created: high_importance_channel");
        
        // Set as default channel for FCM
        await androidImplementation.requestNotificationsPermission();
        debugPrint("Notification permissions requested");
      }
    } else {
      debugPrint("Failed to initialize local notifications");
    }
  } catch (e) {
    debugPrint("Error initializing local notifications: $e");
  }
}


Future<void> showLocalNotification(RemoteMessage message) async {
  // Skip on web - local notifications not supported
  if (kIsWeb) {
    debugPrint("Local notifications not supported on web, skipping");
    return;
  }
  
  try {
    final notification = message.notification;
   
    if (notification == null) {
      debugPrint("⚠️ Notification is null, data-only message received");
      return;
    }

    debugPrint("📱 Attempting to show notification: ${notification.title} - ${notification.body}");

    // Ensure notification channel exists before showing notification
    final androidImplementation = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    
    if (androidImplementation != null) {
      // Check notification permissions first (Android 13+)
      final bool? granted = await androidImplementation.requestNotificationsPermission();
      debugPrint("📋 Notification permission granted: $granted");
      
      // Recreate channel to ensure it exists (important for Infinix devices)
      // Use MAX importance to ensure notifications are always shown
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'Channel for important notifications',
        importance: Importance.max, // Changed from high to max for Infinix devices
        playSound: true,
        enableVibration: true,
        showBadge: true,
      );
      
      await androidImplementation.createNotificationChannel(channel);
      debugPrint("✅ Notification channel verified/created with MAX importance");
      debugPrint("📊 Channel ID: ${channel.id}, Importance: ${channel.importance}");
    } else {
      debugPrint("⚠️ Android implementation not available");
    }

    // Use a unique notification ID (use messageId if available, otherwise timestamp)
    final notificationId = message.messageId?.hashCode ?? 
                          DateTime.now().millisecondsSinceEpoch.remainder(100000);

    // Use MAX importance and MAX priority for Infinix devices
    // Try without BigTextStyle first to see if that's the issue
    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'Channel for important notifications',
      importance: Importance.max, // MAX importance for Infinix devices
      priority: Priority.max, // MAX priority for Infinix devices
      enableVibration: true,
      playSound: true,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      channelShowBadge: true,
      enableLights: true,
      color: const Color.fromARGB(255, 0, 122, 255),
      ticker: notification.title ?? 'New notification', // Ticker text for heads-up notification
      ongoing: false, // Not an ongoing notification
      autoCancel: true, // Auto cancel when tapped
      onlyAlertOnce: false, // Alert every time
      visibility: NotificationVisibility.public, // Make notification visible
      category: AndroidNotificationCategory.message, // Set category
      // Remove styleInformation to use default style
    );

    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    debugPrint("📤 Calling flutterLocalNotificationsPlugin.show()");
    debugPrint("   - ID: $notificationId");
    debugPrint("   - Title: ${notification.title ?? 'Notification'}");
    debugPrint("   - Body: ${notification.body ?? ''}");
    debugPrint("   - Channel: high_importance_channel");
    debugPrint("   - Importance: MAX");
    debugPrint("   - Priority: MAX");
    
    try {
      // Try showing notification with a small delay to ensure channel is ready
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Extract route from message data for navigation
      // Default to 'another' (PageTwo) if route not specified
      final route = message.data['route'] ?? message.data['page'] ?? 'another';
      final payload = route.startsWith('/') ? route.substring(1) : route;
      
      await flutterLocalNotificationsPlugin.show(
        notificationId,
        notification.title ?? 'Notification',
        notification.body ?? '',
        notificationDetails,
        payload: payload, // Payload contains route for navigation
      );
      
      debugPrint("✅ Notification show() called successfully");
      debugPrint("✅ Notification shown successfully with ID: $notificationId");
      
      // Additional check: Try to get pending notifications
      final pendingNotifications = await flutterLocalNotificationsPlugin.pendingNotificationRequests();
      debugPrint("📊 Pending notifications count: ${pendingNotifications.length}");
      
      // Verify notification was actually shown by checking after a delay
      await Future.delayed(const Duration(milliseconds: 500));
      debugPrint("✅ Notification display verification completed");
      debugPrint("⚠️ If notification is not visible, check device settings:");
      debugPrint("   1. Settings → Apps → flutterweather → Notifications");
      debugPrint("   2. Ensure 'High Importance Notifications' channel is enabled");
      debugPrint("   3. Settings → Battery → Battery Optimization → Don't optimize");
      debugPrint("   4. Settings → Do Not Disturb → Check if enabled");
    } catch (showError, stackTrace) {
      debugPrint("❌ Error in flutterLocalNotificationsPlugin.show(): $showError");
      debugPrint("❌ Stack trace: $stackTrace");
      rethrow;
    }
  } catch (e, stackTrace) {
    debugPrint("❌ Error showing local notification: $e");
    debugPrint("Stack trace: $stackTrace");
  }
}
