import 'package:flutter/material.dart';
import 'package:flutter_todo_list/model/task_model.dart';

import '../screens/task_editor.dart';

class TaskListTile extends StatefulWidget {
  TaskListTile({required this.task, required this.index, Key? key})
      : super(key: key);
  TaskModel task;
  int index;
  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, top: 12),
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.task.title ?? 'Empty',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                  splashColor: Colors.grey,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskEditor(task: widget.task),
                        ));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                  )),
              IconButton(
                  splashColor: Colors.grey,
                  onPressed: () {
                    widget.task.delete();
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ),
          Divider(
            color: Colors.black87,
            height: 20,
            thickness: 1,
          ),
          Text(
            widget.task.note ?? 'Empty',
            style: TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
