
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
