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
}

class AyatModel {
  static String tableName = "Quran";
  final int id;
  final String ayaText;
  final String ayaSearchText;
  final int ayaNumber;
  AyatModel({
    required this.id,
    required this.ayaText,
    required this.ayaSearchText,
    required this.ayaNumber,
  });

  static List<String> columns = [
    "ID",
    "AyaDiac",
    "SearchText",
    "AyaNum",
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'AyaDiac': ayaText,
      'SearchText': ayaSearchText,
      'ayaNum': ayaNumber,
    };
  }

  factory AyatModel.fromMap(Map map) {
    return AyatModel(
      id: map['ID'] as int,
      ayaText: map['AyaDiac'] as String,
      ayaSearchText: map['SearchText'] as String,
      ayaNumber: map['AyaNum'] as int,
    );
  }
}
