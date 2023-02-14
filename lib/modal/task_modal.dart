import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'task_modal.g.dart';

@HiveType(typeId: 0)
class TaskModel{
  @HiveField(0)
  final String mainTitle;


  @HiveField(1)
  final String date ;

  @HiveField(2)
  List<Task> dailyWork;
  TaskModel({required this.mainTitle, required this.date,  required this.dailyWork,});
}

@HiveType(typeId: 1)
class Task{
  @HiveField(0)
  final String name;

  @HiveField(1)
  bool isDone;

  Task({required this.name, this.isDone = false});
  void toggleDone(){
    isDone = !isDone;
  }
}

@HiveType(typeId: 2)
class ProfileModel{
  @HiveField(0)
  late  String about1;

  @HiveField(1)
  late  String about2;

  @HiveField(2)
  late  Uint8List? image1;

  @HiveField(3)
  late  Uint8List? image2;

  // @HiveField(4)
  // late  bool bool1;

  // @HiveField(5)
  // late  bool bool2;


  ProfileModel({
    required this.about1,
    required this.about2,
    required this.image1,
    required this.image2,
    // required this.bool1,
    // required this.bool2,
  });

}