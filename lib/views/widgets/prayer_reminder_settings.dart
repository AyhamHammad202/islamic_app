import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/helper.dart';

class PrayerReminder extends StatelessWidget {
  final String prayerName;
  final String reminderText;
  final String settingsKey;
  final int notificationId;
  final String channelKey;
  final bool isEnabled;
  final void Function(bool isEnabled) updateValue;

  const PrayerReminder({
    super.key,
    required this.prayerName,
    required this.reminderText,
    required this.settingsKey,
    required this.notificationId,
    required this.channelKey,
    required this.isEnabled,
    required this.updateValue,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeColor: kThirdlyColor,
      title: Text(
        prayerName,
        style: TextStyle(
          fontSize: 16.sp,
          color: kThirdlyColor,
          fontFamily: kFontKufamRegular,
        ),
      ),
      subtitle: Text(
        reminderText,
        style: TextStyle(
          fontSize: 16.sp,
          color: kThirdlyColor,
          fontFamily: kFontKufamRegular,
        ),
      ),
      value: isEnabled,
      onChanged: (value) async {
        if (value == true) {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: notificationId,
                channelKey: channelKey,
                title: prayerName,
                body: "$prayerName يرحمك الله",
                largeIcon: "asset://assets/icon/quran.png",
                wakeUpScreen: true,
                fullScreenIntent: true,
              ),
              schedule: NotificationCalendar(
                hour: pickedTime.hour,
                minute: pickedTime.minute,
                second: 0,
                millisecond: 0,
                repeats: true,
              ),
            );
            if (context.mounted) {
              show(
                  context: context,
                  message:
                      "تم جدولة الأشعار يوميا بالوقت الذي اخترته ${pickedTime.hour}:${pickedTime.minute}");
            }
          } else {
            if (context.mounted) {
              show(context: context, message: "يجب ان تختار وقت صحيحا");
            }
            updateValue(false);
            return;
          }
        } else {
          AwesomeNotifications().cancelSchedule(notificationId);
        }
        updateValue(value);
      },
    );
  }
}
