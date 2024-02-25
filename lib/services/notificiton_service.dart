import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';

// class NotificationController {

//   /// Use this method to detect when a new notification or a schedule is created
//   @pragma("vm:entry-point")
//   static Future <void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }

//   /// Use this method to detect every time that a new notification is displayed
//   @pragma("vm:entry-point")
//   static Future <void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }

//   /// Use this method to detect if the user dismissed a notification
//   @pragma("vm:entry-point")
//   static Future <void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
//     // Your code goes here
//   }

//   /// Use this method to detect when the user taps on a notification or action button
//   @pragma("vm:entry-point")
//   static Future <void> onActionReceivedMethod(ReceivedAction receivedAction) async {
//     // Your code goes here

//     // Navigate into pages, avoiding to open the notification details page over another details page already opened
//     MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(QuranView.id,
//             (route) => (route.settings.name != '/notification-page') || route.isFirst,
//         arguments: receivedAction);
//   }
// }

class NotificationService extends GetxService {
  Future<NotificationService> init()async {
    await AwesomeNotifications().initialize("resource://drawable/quran", [
    NotificationChannel(
      channelKey: "salatAldoha",
      channelName: "صلاة الضحى",
      channelDescription: "التذكير بصلاة الضحى",
      groupKey: "salatReminder",
      icon: "resource://drawable/quran",
      enableLights: true,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
    NotificationChannel(
      channelKey: "salatAlotr",
      channelName: "صلاة الوتر",
      channelDescription: "التذكير بصلاة الوتر",
      groupKey: "salatReminder",
      icon: "resource://drawable/quran",
      enableLights: true,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    )
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: "salatReminder", channelGroupName: "salatGroub")
  ]);
  if (!await AwesomeNotifications().isNotificationAllowed()) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
    return this;
  }
}


//these lines were init state in MyApp Widget
// AwesomeNotifications().setListeners(
//   onActionReceivedMethod: NotificationController.onActionReceivedMethod,
//   onNotificationCreatedMethod:
//       NotificationController.onNotificationCreatedMethod,
//   onNotificationDisplayedMethod:
//       NotificationController.onNotificationDisplayedMethod,
//   onDismissActionReceivedMethod:
//       NotificationController.onDismissActionReceivedMethod,
// );