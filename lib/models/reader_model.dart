class ReaderModel {
  final int id;
  final String arabicName;
  final String englishName;
  final String link;
  final String image;

  ReaderModel({
    required this.id,
    required this.image,
    required this.arabicName,
    required this.englishName,
    required this.link,
  });

  factory ReaderModel.fromMap(Map<String, dynamic> map) {
    return ReaderModel(
      id: map['id'] as int,
      arabicName: map['nameAr'] as String,
      englishName: map['nameEn'] as String,
      link: map['link'] as String,
      image: map['image'] as String,
    );
  }
}
