import 'package:flutter/material.dart';
import 'package:flutter_todo_list/model/task_model.dart';
import 'package:flutter_todo_list/screens/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  box = await Hive.openBox<TaskModel>('tasks');
  box.add(TaskModel(
      title: 'This is the first task',
      note: 'This is the first Note',
      creation_date: DateTime.now()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}