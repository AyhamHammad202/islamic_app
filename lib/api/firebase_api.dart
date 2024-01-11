import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  //create an instance of firebase messaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notifictions
  Future<void> initNotifictions() async {
    //request permission from user
    await _firebaseMessaging.requestPermission();

    //Fetch the FCM token for the device
    // final fCMToken = await _firebaseMessaging.getToken();
    // log("FCM Token=${fCMToken}");
  }

  // //function to handle received messages
  // void handleMessage(RemoteMessage? message) {
  //   if (message == null) return;
  //   //   navigatorKey.currentState?.
  // }

  // //function to initialize foreground and background settings
  // void initPushNotificiton() {
  //   FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  // }
}
