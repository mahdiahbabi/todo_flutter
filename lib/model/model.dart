import 'package:hive_flutter/adapters.dart';
part 'model.g.dart';
@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String TaskTitle = '';
  @HiveField(1)
  String TaskDetail = '';
  @HiveField(2)
  DateTime Time = DateTime.now();
  @HiveField(3)
  Categori categori = Categori.study;
  @HiveField(4)
  bool iscompleted = false;
}

@HiveType(typeId: 1)
enum Categori {
  @HiveField(0)
  work,
  @HiveField(1)
  study,
  @HiveField(2)
  sport,
}
