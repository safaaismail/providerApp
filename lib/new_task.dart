import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saafaa/app_provider.dart';
import 'package:saafaa/task_model.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String taskName;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => taskName = value,
              decoration: InputDecoration(
                hintText: 'Task Title',
                fillColor: Colors.grey,
                filled: true,
              ),
              style: TextStyle(fontSize: 24),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 30),
            Checkbox(
                value: this.isCompleted,
                onChanged: (value) {
                  this.isCompleted = !this.isCompleted;
                  setState(() {});
                }),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Provider.of<AppProvider>(context, listen: false)
                      .insertTask(Task(this.taskName, this.isCompleted));
                  Navigator.pop(context);
                },
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 24),
                ),
                color: Colors.blue,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
