import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/controllers/quran_controller.dart';

class YearOccasionView extends StatelessWidget {
  const YearOccasionView({super.key});

  @override
  Widget build(BuildContext context) {
    HijriCalendar hijriCalendar = HijriCalendar.now();
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              Text(
                "سنة ${hijriCalendar.hYear}",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              OccasionWidget(
                occasionTitle: "رمضان",
                year: hijriCalendar.hYear,
                month: 9,
                day: 1,
              ),
              OccasionWidget(
                occasionTitle: "عيد الفطر",
                year: hijriCalendar.hYear,
                month: 10,
                day: 1,
              ),
              OccasionWidget(
                occasionTitle: "يوم عرفة",
                year: hijriCalendar.hYear,
                month: 12,
                day: 9,
              ),
              OccasionWidget(
                occasionTitle: "عيد الأضحى",
                year: hijriCalendar.hYear,
                month: 12,
                day: 10,
              ),
              OccasionWidget(
                occasionTitle: "السنة الهجرية الجديدة",
                year: hijriCalendar.hYear + 1,
                month: 1,
                day: 1,
              ),
              Text(
                "سنة ${hijriCalendar.hYear}",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              OccasionWidget(
                occasionTitle: "رمضان",
                year: hijriCalendar.hYear + 1,
                month: 9,
                day: 1,
              ),
              OccasionWidget(
                occasionTitle: "عيد الفطر",
                year: hijriCalendar.hYear + 1,
                month: 10,
                day: 1,
              ),
              OccasionWidget(
                occasionTitle: "يوم عرفة",
                year: hijriCalendar.hYear + 1,
                month: 12,
                day: 9,
              ),
              OccasionWidget(
                occasionTitle: "عيد الأضحى",
                year: hijriCalendar.hYear + 1,
                month: 12,
                day: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OccasionWidget extends StatelessWidget {
  const OccasionWidget(
      {super.key,
      required this.occasionTitle,
      required this.year,
      required this.month,
      required this.day});
  final String occasionTitle;
  final int year;
  final int month;
  final int day;

  @override
  Widget build(BuildContext context) {
    QuranController quranController = Get.find();
    int leftDays = quranController.calucate(year, month, day);
    return Stack(
      children: [
        Container(
          width: quranController.calculateProgress(
              10, leftDays == 0 ? 10 : leftDays),
          height: 25,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.4),
          ),
          child: Row(
            children: [
              Text(occasionTitle),
              Text(
                "${leftDays == 0 ? "اتى" : leftDays}",
              )
            ],
          ),
        ),
      ],
    );
  }
}
