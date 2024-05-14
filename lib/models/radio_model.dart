class RadioModel {
  final String arabicName;
  final String englishName;
  final String link;

  RadioModel({
    required this.arabicName,
    required this.englishName,
    required this.link,
  });

  factory RadioModel.fromMap(Map<String, dynamic> map) {
    return RadioModel(
      arabicName: map['nameAr'] as String,
      englishName: map['nameEn'] as String,
      link: map['link'] as String,
    );
  }
}
