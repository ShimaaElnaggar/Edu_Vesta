import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handelBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();
    if (token != null) {
      print('FCM token: $token');
    } else {
      print('Failed to get token');
    }

    FirebaseMessaging.onBackgroundMessage(handelBackgroundMessage);
  }

  void handelMessage(RemoteMessage? message) {
    if (message?.notification != null) return;
  }

  Future<void> initPushNotifications() async {}


}