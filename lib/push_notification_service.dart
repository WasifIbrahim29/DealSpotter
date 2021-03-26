import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static void getPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  static Future initialise() async {
    // If you want to test the push notification locally,
    // you need to get the token and input to the Firebase console
    // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
    String token = await messaging.getToken();
    print("FirebaseMessaging token: $token");
    globals.user.deviceToken = token;
  }
}
