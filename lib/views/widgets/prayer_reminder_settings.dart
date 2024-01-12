import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/services/settings_service.dart';

class PrayerReminder extends StatefulWidget {
  final String prayerName;
  final String reminderText;
  final String settingsKey;
  final int notificationId;
  final String channelKey;
  final SettingsService settingsService;

  const PrayerReminder({
    required this.prayerName,
    required this.reminderText,
    required this.settingsKey,
    required this.notificationId,
    required this.channelKey,
    required this.settingsService,
  });

  @override
  _PrayerReminderState createState() => _PrayerReminderState();
}

class _PrayerReminderState extends State<PrayerReminder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.settingsService.getBoolValue(widget.settingsKey),
      builder: (context, snapshot) {
        return SwitchListTile(
          activeColor: kThirdlyColor,
          title: Text(
            widget.prayerName,
            style: TextStyle(
              fontSize: 16.sp,
              color: kThirdlyColor,
              fontFamily: kFontKufamRegular,
            ),
          ),
          subtitle: Text(
            widget.reminderText,
            style: TextStyle(
              fontSize: 16.sp,
              color: kThirdlyColor,
              fontFamily: kFontKufamRegular,
            ),
          ),
          value: snapshot.data ?? false,
          onChanged: (value) async {
            if (value == true) {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                AwesomeNotifications().createNotification(
                  content: NotificationContent(
                    id: widget.notificationId,
                    channelKey: widget.channelKey,
                    title: widget.prayerName,
                    body: "${widget.prayerName} يرحمك الله",
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
                show(
                    context: context,
                    message:
                        "تم جدولة الأشعار يوميا بالوقت الذي اخترته ${pickedTime.hour}:${pickedTime.minute}");
              } else {
                show(context: context, message: "يجب ان تختار وقت صحيحا");
                setState(() {
                  widget.settingsService
                      .saveBoolValue(widget.settingsKey, false);
                });
                return;
              }
            } else {
              AwesomeNotifications().cancelSchedule(widget.notificationId);
            }
            setState(() {
              widget.settingsService.saveBoolValue(widget.settingsKey, value);
            });
          },
        );
      },
    );
  }
}
