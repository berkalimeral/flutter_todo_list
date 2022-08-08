import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String? title;
  
  @HiveField(1)
  String? note;
  
  @HiveField(2)
  DateTime? creation_date;
  
  @HiveField(3)
  bool? done;
  TaskModel({
    this.title,
    this.note,
    this.creation_date,
    this.done,
  });

  

}
