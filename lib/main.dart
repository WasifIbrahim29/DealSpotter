import 'package:deal_spotter/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'push_notification_service.dart';
import 'screens/welcome_screen.dart';
import 'package:deal_spotter/globals/globals.dart' as globals;
import 'models/notification.dart';

import 'constants.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

void main() async {
  String messageTitle = "Empty";
  String notificationAlert = "alert";

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PushNotificationService.getPermission();
  PushNotificationService.initialise();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(DealSpotter());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
  NotificationModel notification = NotificationModel();
  notification.messageTitle = message.notification.title;
  notification.notificationAlert = message.notification.body;
  globals.notifications.add(notification);
  print("Title: " + message.notification.title);
  print("Body: " + message.notification.body);
  print(globals.notifications.length);
}

class DealSpotter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: MaterialApp(
        key: mainNavigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
        },
      ),
    );
  }
}
