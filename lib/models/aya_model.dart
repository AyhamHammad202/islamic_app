class AyaModel {
  final int id;
  final String ar;
  final String en;
  AyaModel({
    required this.id,
    required this.ar,
    required this.en,
  });

  factory AyaModel.fromMap(Map<String, dynamic> map) {
    return AyaModel(
      id: map['id'] as int,
      ar: map['ar'] as String,
      en: map['en'] as String,
    );
  }
}
