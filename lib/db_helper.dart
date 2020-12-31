import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  static String databaseName = 'tasksDb.db';
  static String tableName = 'tasks';
  static String taskIdColumnName = 'id';
  static String taskNameColumnName = 'name';
  static String taskIsCompleteColumnName = 'isComplete';

  Database database;
  Future<Database> initDatabase() async {
    if (database == null) {
      return await createDatabase();
    } else {
      return database;
    }
  }

  Future<Database> createDatabase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, databaseName);
      Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute('''CREATE TABLE $tableName(
            $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $taskNameColumnName TEXT NOT NULL,
            $taskIsCompleteColumnName INTEGER
          )''');
        },
      );
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map>> getAllTasks() async {
    try {
      database = await initDatabase();
      List<Map> result = await database.query(tableName);
      return result;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
