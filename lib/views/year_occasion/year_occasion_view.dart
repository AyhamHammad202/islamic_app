import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/views/year_occasion/widgets/occasion_widget.dart';

class YearOccasionView extends StatelessWidget {
  const YearOccasionView({super.key});

  @override
  Widget build(BuildContext context) {
    HijriCalendar hijriCalendar = HijriCalendar.now();
    final List<String> titles = [
      S.of(context).ramadan,
      S.of(context).eid_al_fitr,
      S.of(context).arafah,
      S.of(context).eid_al_adha,
      S.of(context).islamic_new_year,
    ];
    final List<int> months = [
      9,
      10,
      12,
      12,
      1,
    ];
    final List<int> days = [
      1,
      1,
      9,
      10,
      1,
    ];
    final List<int> years = [
      hijriCalendar.hYear,
      hijriCalendar.hYear + 1,
    ];
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(S.current.islamicOccasions),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            // index == months.length ? index = 0 : index = index;
            int dis = index % months.length;
            return OccasionWidget(
              occasionTitle: titles[dis],
              year: years[index <= months.length - 2 ? 0 : 1],
              month: months[dis],
              day: days[dis],
            );
          },
          itemCount: months.length * 2 - 1,
        ),
      ),
    );
  }
}
