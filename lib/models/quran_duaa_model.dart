class QuranDuaaModel {
  final String sura;
  final String suraNum;
  final List<DuaaModel> ayas;
  // final String duaa;

  QuranDuaaModel({
    required this.sura,
    required this.suraNum,
    required this.ayas,
    // required this.aya,
    // required this.duaa,
  });

  factory QuranDuaaModel.fromMap(Map<String, dynamic> map) {
    var list = map['ayahs'] as List;
    List<DuaaModel> ayahList = list.map((i) => DuaaModel.fromMap(i)).toList();
    return QuranDuaaModel(
      sura: map['name'] as String,
      suraNum: map['surah'] as String,
      ayas: ayahList,
      // aya: map['ayahs'][0]['ayahNumber'] as String,
      // duaa:map['ayahs'][0]['ayah'] as String,
    );
  }
}

class DuaaModel {
  final String aya;
  final String duaa;

  DuaaModel({
    required this.aya,
    required this.duaa,
  });

  factory DuaaModel.fromMap(Map<String, dynamic> map) {
    return DuaaModel(
      aya: map['ayahNumber'] as String,
      duaa: map['ayah'] as String,
    );
  }
}
