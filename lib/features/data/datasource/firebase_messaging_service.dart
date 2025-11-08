import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Top-level function for handling background messages
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Background message received: ${message.messageId}");
}

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      debugPrint("FCM Token: $token");
      return token;
    } catch (e) {
      debugPrint("Error getting FCM token: $e");
      return null;
    }
  }

  // Check current notification permission status
  Future<AuthorizationStatus> getPermissionStatus() async {
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

  // Initialize FCM (without requesting permission - call requestPermission separately)
  Future<void> initialize({bool requestPermissionOnInit = false}) async {
    try {
      // Check permission status first
      final currentStatus = await getPermissionStatus();
      debugPrint("Current notification permission: $currentStatus");

      // Only request permission if explicitly requested and not already granted
      if (requestPermissionOnInit && currentStatus != AuthorizationStatus.authorized) {
        await requestPermission();
      }

      // Get token if permission is granted
      if (currentStatus == AuthorizationStatus.authorized || 
          currentStatus == AuthorizationStatus.provisional) {
        await getToken();
      }

      // Setup foreground message handler
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint("Foreground message received: ${message.messageId}");
        debugPrint("Message data: ${message.data}");
        debugPrint("Message notification: ${message.notification?.title}");
      });

      // Setup message opened handler (when user taps notification)
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint("Message opened app: ${message.messageId}");
        debugPrint("Message data: ${message.data}");
      });

      // Check if app was opened from a notification
      RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        debugPrint("App opened from notification: ${initialMessage.messageId}");
      }

      // Setup token refresh handler
      _firebaseMessaging.onTokenRefresh.listen((String token) {
        debugPrint("FCM Token refreshed: $token");
      });
    } catch (e) {
      debugPrint("Error initializing FCM: $e");
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
//   const AndroidInitializationSettings androidInitSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   const InitializationSettings initSettings =
//       InitializationSettings(android: androidInitSettings);

//   await flutterLocalNotificationsPlugin.initialize(initSettings);
FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  debugPrint("Foreground message received: ${message.messageId}");
  debugPrint("Message data: ${message.data}");
  debugPrint("Message notification: ${message.notification?.title}");

  await showLocalNotification(message);
});

 }


Future<void> showLocalNotification(RemoteMessage message) async {
  final notification = message.notification;
  if (notification == null) return;

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    channelDescription: 'Channel for important notifications',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    DateTime.now().millisecondsSinceEpoch ~/ 1000,
    notification.title,
    notification.body,
    notificationDetails,
  );
}
