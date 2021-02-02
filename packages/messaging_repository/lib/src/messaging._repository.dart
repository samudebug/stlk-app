import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessagingRepository {
  FirebaseMessaging _firebaseMessaging;
  FlutterLocalNotificationsPlugin notificationsPlugin;
  MessagingRepository() {
    AndroidInitializationSettings initializationSettings =
        AndroidInitializationSettings('ic_launcher');
    InitializationSettings settings =
        InitializationSettings(android: initializationSettings);
    notificationsPlugin = FlutterLocalNotificationsPlugin();
    notificationsPlugin.initialize(settings);
    _firebaseMessaging = FirebaseMessaging.instance;

    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onBackgroundMessage(onMessage);
  }

  static Future<dynamic> onMessage(RemoteMessage message) async {
    print('Mensagem');
    // FlutterLocalNotificationsPlugin notificationsPlugin;
    // AndroidInitializationSettings initializationSettings =
    //     AndroidInitializationSettings('ic_launcher');
    // InitializationSettings settings =
    //     InitializationSettings(android: initializationSettings);
    // notificationsPlugin = FlutterLocalNotificationsPlugin();
    // notificationsPlugin.initialize(settings);
    // AndroidNotificationDetails androidNotificationDetails =
    //     AndroidNotificationDetails(
    //         "stlk-not-sub", "Notificações do STLK", "Notificações do STLK",
    //         importance: Importance.max,
    //         priority: Priority.high,
    //         showWhen: false);
    // NotificationDetails details =
    //     NotificationDetails(android: androidNotificationDetails);
    // notificationsPlugin.show(
    //     0,
    //     'Nova postagem!',
    //     "${message.data['socialMediaName']} acabou de postar no ${message.data['socialMediaHandle']}",
    //     details);
  }

  Future<String> getDeviceToken() async {
    return await _firebaseMessaging.getToken(
        vapidKey:
            'BJQ0WSu41Bj_aGMxUxSRH1xBS2bkSyjueoyyqXvTruS1_9ztDn81pmoi7PphzJoeSGbOz5SKGuGTYDV9rMVB0Tg');
  }
}
