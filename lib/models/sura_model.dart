// ignore_for_file: public_member_api_docs, sort_constructors_first
class SuraModel {
  final String titleAr;
  final String titleEn;
  final String index;
  final int allAyaNumber;
  final String place;
  final String type;
  SuraModel({
    required this.titleAr,
    required this.titleEn,
    required this.index,
    required this.allAyaNumber,
    required this.place,
    required this.type,
  });


  factory SuraModel.fromMap(Map<String, dynamic> map) {
    return SuraModel(
      titleAr: map['titleAr'] as String,
      titleEn: map['title'] as String,
      index: map['index'] as String,
      allAyaNumber: map['count'] as int,
      place: map['place'] as String,
      type: map['type'] as String,
    );
  }

}
