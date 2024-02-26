import 'aya_of_surah_model.dart';

class SurahModel {
  final int numberOfSurah;
  final String nameOfSurah;
  final String englishNameOfSurah;
  final String englishNameTranslationOfSurah;
  final String revelationType;
  final List<AyaOfSurahModel> ayas;

  SurahModel({
    required this.numberOfSurah,
    required this.nameOfSurah,
    required this.englishNameOfSurah,
    required this.englishNameTranslationOfSurah,
    required this.revelationType,
    required this.ayas,
  });

  factory SurahModel.fromMap(Map map) {
    return SurahModel(
        numberOfSurah: map['number'],
        nameOfSurah: map['name'],
        englishNameOfSurah: map['englishName'],
        englishNameTranslationOfSurah: map['englishNameTranslation'],
        revelationType: map['revelationType'],
        ayas: (map['ayahs'] as List)
            .map((e) => AyaOfSurahModel.fromMap(e))
            .toList()
        // List<AyaOfSurahModel>.from(
        //   map['ayahs'].map(
        //     (aya) => AyaOfSurahModel.fromMap(aya),
        //   ),
        // ),
        );
  }
}
