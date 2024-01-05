import 'package:islamic_app/helper.dart';

class LastReadModel {
  final int pageNum;
  final int soraNum;
  final String soraEnName;
  final String soraArName;
  final int ayaNum;
  final String dateTime;

  LastReadModel({
    required this.pageNum,
    required this.soraNum,
    required this.soraEnName,
    required this.soraArName,
    required this.ayaNum,
    required this.dateTime,
  });

  static final String table = "Quran";
  static final List<String> columns = [
    "PageNum",
    "SoraNum",
    "SoraName_En",
    "SoraName_ar",
    "AyaNum",
  ];

  factory LastReadModel.fromMap(Map<String, dynamic> map) {
    return LastReadModel(
      pageNum: map['PageNum'],
      soraNum: map['SoraNum'],
      soraEnName: map['SoraName_En'],
      soraArName: map['SoraName_ar'],
      ayaNum: map['AyaNum'],
      dateTime:
          "${DateTime.now().day.toArabic()}/${DateTime.now().month.toArabic()}/${DateTime.now().year.toArabic()}",
    );
  }
}
