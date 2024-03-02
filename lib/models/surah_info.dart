class SurahInfoModel {
  final int id;
  final String suraName;
  final String ayat;
  final String itsNameMeaning;
  final String reasonOfName;
  final String itsNames;
  final String maqsad;
  final String reasonOfNuzolha;
  final List<String> fadluha;
  final List<String> munasaba;

  SurahInfoModel({
    required this.id,
    required this.suraName,
    required this.ayat,
    required this.itsNameMeaning,
    required this.reasonOfName,
    required this.itsNames,
    required this.maqsad,
    required this.reasonOfNuzolha,
    required this.fadluha,
    required this.munasaba,
  });

  factory SurahInfoModel.fromMap(Map<String, dynamic> map) {
    return SurahInfoModel(
      id: map['id'] as int,
      suraName: map['surah'] as String,
      ayat: map['ayaatiha'] as String,
      itsNameMeaning: map['maeni_asamuha'] as String,
      reasonOfName: map['sabab_tasmiatiha'] as String,
      itsNames: map['asmawuha'] as String,
      maqsad: map['maqsiduha_aleamu'] as String,
      reasonOfNuzolha: map['sabab_nuzuliha'] as String,
      fadluha: List<String>.from(map['fadluha'] as List<dynamic>),
      munasaba: List<String>.from(map['munasabatiha'] as List<dynamic>),
    );
  }
}
