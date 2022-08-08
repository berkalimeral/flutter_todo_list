import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_todo_list/model/task_model.dart';
import 'package:flutter_todo_list/screens/home_page.dart';
import 'package:hive_flutter/adapters.dart';

class TaskEditor extends StatefulWidget {
  TaskModel? task;
  TaskEditor({
    Key? key,
    this.task,
  }) : super(key: key);

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    TextEditingController title_controller = TextEditingController(
        text: widget.task == null ? null : widget.task!.title);
    TextEditingController note_controller = TextEditingController(
        text: widget.task == null ? null : widget.task!.title);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.task == null ? 'Add a new Task' : ' Update your Task',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Task's Title",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: title_controller,
                decoration: InputDecoration(
                    fillColor: Colors.blue.shade100.withAlpha(75),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Your Task'),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Your Task's Note",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 25,
                controller: note_controller,
                decoration: InputDecoration(
                    fillColor: Colors.blue.shade100.withAlpha(75),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Write Some Note'),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    child: RawMaterialButton(
                      onPressed: () async {
                        var newTask = TaskModel(
                            title: title_controller.text,
                            note: note_controller.text,
                            creation_date: DateTime.now(),
                            done: false);

                        Box taskBox = Hive.box<TaskModel>('tasks');
                        if (widget.task != null) {
                          widget.task!.title = newTask.title;
                          widget.task!.note = newTask.note;
                          widget.task!.creation_date = newTask.creation_date;
                          widget.task!.done = newTask.done;

                          widget.task!.save();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                        } else {
                          await taskBox.add(newTask);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                        }
                      },
                      fillColor: Colors.blueAccent.shade700,
                      child: Text(
                        widget.task == null ? 'Add New Task' : 'Update Task',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
