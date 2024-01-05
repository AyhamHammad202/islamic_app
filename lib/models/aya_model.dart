// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuranAyat {
  static String tableName = "Quran";
  final String soraNameAr;
  final String soraNameEn;
  final String soraSearchName;
  final int soraNumber;
  final List<AyatModel> ayat;
  QuranAyat({
    required this.soraNameAr,
    required this.soraNameEn,
    required this.soraSearchName,
    required this.soraNumber,
    required this.ayat,
  });

  static List<String> columns = [
    "SoraName_ar",
    "SoraName_en",
    "SoraNameSearch",
    "SoraNum",
  ];
}

class AyatModel {
  static String tableName = "Quran";
  final int id;
  final String ayaText;
  final String ayaSearchText;
  final int ayaNumber;
  final int ayaPage;
  final String soraNameAr;
  final String soraNameEn;
  final String soraSearchName;
  final int soraNumber;
  final String taffser;
  AyatModel({
    required this.id,
    required this.ayaText,
    required this.ayaSearchText,
    required this.ayaNumber,
    required this.ayaPage,
    required this.soraNameAr,
    required this.soraNameEn,
    required this.soraSearchName,
    required this.soraNumber,
    required this.taffser,
  });

  static List<String> columns = [
    "ID",
    "AyaDiac",
    "SearchText",
    "AyaNum",
    "PageNum",
    "SoraName_ar",
    "SoraName_En",
    "SoraNameSearch",
    "SoraNum",
    "taffser_saadi"
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'AyaDiac': ayaText,
      'SearchText': ayaSearchText,
      'ayaNum': ayaNumber,
      "PageNum":ayaPage,
      'SoraName_ar': soraNameAr,
      'SoraName_en': soraNameEn,
      'SoraNameSearch': soraSearchName,
      'SoraNum': soraNumber,
      'taffser_saadi': taffser,
    };
  }

  factory AyatModel.fromMap(Map map) {
    return AyatModel(
      id: map['ID'] as int,
      ayaText: map['AyaDiac'] as String,
      ayaSearchText: map['SearchText'] as String,
      ayaNumber: map['AyaNum'] as int,
      ayaPage: map['PageNum']as int,
      soraNameAr: map['SoraName_ar'] as String,
      soraNameEn: map['SoraName_En'] as String,
      soraSearchName: map['SoraNameSearch'] as String,
      soraNumber: map['SoraNum'] as int,
      taffser: map['taffser_saadi'] ?? "h",
    );
  }
}
