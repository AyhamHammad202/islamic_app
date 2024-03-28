class TasbehaModel {
  final int id;
  final String tasbeha;
  final String info;
  final int times;
  final bool isAdded;
  TasbehaModel({
    required this.id,
    required this.tasbeha,
    required this.info,
    required this.times,
    required this.isAdded,
  });

  static const String table = "tasbehTable";
  static const List<String> columns = [
    'id',
    'tasbeh',
    'info',
    'times',
    'idAdded',
  ];
  factory TasbehaModel.fromMap(Map<String, dynamic> map) {
    return TasbehaModel(
      id: map['id'] as int,
      tasbeha: map['tasbeh'] as String,
      info: map['info'] as String,
      times: map['times'] as int,
      isAdded: map['isAdded'] == 0 ? false : true,
    );
  }
}
