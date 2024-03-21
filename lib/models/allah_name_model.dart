class AllahNameModel {
  final String name;
  final String meaning;
  AllahNameModel({
    required this.name,
    required this.meaning,
  });

  factory AllahNameModel.fromMap(Map<String, dynamic> map) {
    return AllahNameModel(
      name: map['name'] as String,
      meaning: map['meaning'] as String,
    );
  }
}
