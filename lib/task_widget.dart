import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_provider.dart';
import 'package:saafaa/app_provider.dart';
import 'package:saafaa/task_model.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  final Function function;
  TaskWidget(this.task, [this.function]);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  showAlertDialog(BuildContext context) {
    Widget noButton = FlatButton(
      child: Text("cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget yesButton = FlatButton(
      child: Text("ok"),
      onPressed: () {
        Provider.of<AppProvider>(context, listen: false)
            .deleteTask(widget.task);
        setState(() {});
        widget.function();
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Dialog Title"),
      content: Text("do u want to delete the task?"),
      actions: [noButton, yesButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showAlertDialog(context);
                }),
            Text(widget.task.taskName),
            Checkbox(
                value: widget.task.isCompleted,
                onChanged: (value) {
                  widget.task.isCompleted = !widget.task.isCompleted;
                  Provider.of<AppProvider>(context, listen: false)
                      .updateTask(widget.task);
                  setState(() {});
                  widget.function();
                }),
          ],
        ),
      ),
    );
  }
}
