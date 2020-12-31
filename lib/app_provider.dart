import 'package:flutter/cupertino.dart';
import 'package:saafaa/db_helper.dart';
import 'package:saafaa/task_model.dart';

class AppProvider extends ChangeNotifier {
  List<Task> _tasks = new List();
  List<Task> _getTasks = new List();

  getTasksFromDB(Future<List<Map>> tasks, Function fun) {
    tasks.then((value) {
      value.forEach((element) {
        this._getTasks.add(Task(element[DBHelper.taskNameColumnName],
            element[DBHelper.taskIsCompleteColumnName] == 1 ? true : false));
      });
      fun();
    });
    return this._getTasks;
  }

  setValue(List<Task> tasks) {
    this._tasks = tasks;
    notifyListeners();
  }

  List<Task> getValue() {
    return this._tasks;
  }

  insertTask(Task task) {
    this._tasks.add(task);
    notifyListeners();
  }

  deleteTask(Task task) {
    this._tasks.remove(task);
    notifyListeners();
  }

  updateTask(Task task) {
    this._tasks.forEach((element) {
      if (element.taskName == task.taskName) {
        element.isCompleted = task.isCompleted;
      }
    });
    notifyListeners();
  }
}
