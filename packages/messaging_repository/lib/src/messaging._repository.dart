import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingRepository {
  FirebaseMessaging _firebaseMessaging;
  MessagingRepository() {
    _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.configure(
        onBackgroundMessage: onMessage, onMessage: onMessage);
  }

  static Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print(message);
  }

  Future<String> getDeviceToken() async {
    return await _firebaseMessaging.getToken();
  }
}
