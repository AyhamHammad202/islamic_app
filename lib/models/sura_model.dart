// ignore_for_file: public_member_api_docs, sort_constructors_first

class SuraModel {
  final String titleAr;
  final String titleEn;
  final String nameTranslation;
  final int index;
  final int allAyaNumber;
  final String place;
  final String type;
  final List<dynamic> allAya;
  SuraModel({
    required this.nameTranslation,
    required this.titleAr,
    required this.titleEn,
    required this.index,
    this.allAyaNumber = 1,
    required this.place,
    required this.type,
    required this.allAya,
  });

  factory SuraModel.fromMap(Map<String, dynamic> map) {
    return SuraModel(
      titleAr: map['name'] as String,
      titleEn: map['name_en'] as String,
      index: map['id'] as int,
      place: map['type'] == "مكية" ? "Makkiyah" : "Madaniyah",
      type: map['type'] as String,
      allAya: map['array'] as List<dynamic>,
      nameTranslation: map['name_translation'] as String,
    );
  }
}
