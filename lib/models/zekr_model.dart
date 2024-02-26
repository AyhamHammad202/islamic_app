class ZekrModel {
  final int id;
  final String category;
  final String description;
  final int count;
  final String reference;
  final String zekr;
  ZekrModel({
    required this.id,
    required this.category,
    required this.description,
    required this.count,
    required this.reference,
    required this.zekr,
  });

  static const String table = "AZKER";
  static List<String> columns = [
    "id",
    "category",
    "count",
    "description",
    "reference",
    "zekr",
  ];

  factory ZekrModel.fromMap(Map<String, dynamic> map) {
    return ZekrModel(
      id: map['id'] as int,
      category: map['category'] as String,
      description: map['description'] as String,
      count: map['count'] as int,
      reference: map['reference'] as String,
      zekr: map['zekr'] as String,
    );
  }
}
