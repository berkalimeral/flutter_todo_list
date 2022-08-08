import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_todo_list/screens/task_editor.dart';
import 'package:hive_flutter/adapters.dart';

import '../model/task_model.dart';
import '../widget/task_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box? box;
  @override
  void initState() {
    super.initState();
    box = Hive.box<TaskModel>('tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My ToDo List App',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: box!.listenable(),
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Task",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  formatDate(DateTime.now(), [d, ".", M, ".", yyyy]),
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 18),
                ),
                Divider(
                  height: 40,
                  thickness: 1,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: box!.values.length,
                  itemBuilder: (context, index) {
                    TaskModel currentTask = box!.getAt(index);
                    return TaskListTile(
                      task: currentTask,
                      index: index,
                    );
                  },
                )),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskEditor(),
                ));
          }),
          child: const Icon(Icons.add)),
    );
  }
}
