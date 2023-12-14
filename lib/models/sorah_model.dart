class SorahModel {
  static String tableName = "Sora";
  final int id;
  final String name;
  final String nameEn;
  final String searchText;
  final int ayaCount;
  final int pageNum;
  final String typeAr;
  final String typeEn;

  SorahModel({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.searchText,
    required this.ayaCount,
    required this.pageNum,
    required this.typeAr,
    required this.typeEn,
  });

  static final columns = [
    "Id",
    "Name_ar",
    "Name_en",
    "SearchText",
    'AyatCount',
    'PageNum',
    'TypeText_ar',
    'TypeText_en',
  ];

  Map toMap() {
    Map map = {
      "Name_ar": name,
      "Name_en": nameEn,
      "SearchText": searchText,
      "AyatCount": ayaCount,
      "PageNum": pageNum,
      "TypeText_ar": typeAr,
      "TypeText_en": typeEn,
    };
    map['id'] = id;
    return map;
  }

  factory SorahModel.fromMap(Map map) {
    return SorahModel(
      id : map['Id'],
      name : map['Name_ar'],
      nameEn : map['Name_en'],
      searchText : map['SearchText'],
      ayaCount : map['AyatCount'],
      pageNum : map['PageNum'],
      typeAr : map['TypeText_ar'],
      typeEn : map['TypeText_en'],
    );
  }
}
