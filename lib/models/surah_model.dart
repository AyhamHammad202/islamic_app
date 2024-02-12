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

class AyaOfSurahModel {
  final int numberOfAyaInSurah;
  final int uniqueIdOfAya;
  final String text;
  final String textOfAya;
  final String searchTextOfAya;
  final String audioUrl;
  final int juz;
  final int page;
  final bool sajda;

  AyaOfSurahModel({required this.uniqueIdOfAya, 
    required this.numberOfAyaInSurah,
    required this.text,
    required this.textOfAya,
    required this.searchTextOfAya,
    required this.audioUrl,
    required this.juz,
    required this.page,
    required this.sajda,
  });

  factory AyaOfSurahModel.fromMap(Map map) {
    return AyaOfSurahModel(
      numberOfAyaInSurah: map['numberInSurah'],
      uniqueIdOfAya: map['number'],
      text: map['code_v2'],
      textOfAya: map['text'],
      searchTextOfAya: map['aya_text_emlaey'],
      audioUrl: map['audio'],
      juz: map['juz'],
      page: map['page'],
      // sajda: map['sajda'],
      sajda: false,
    );
  }
}
