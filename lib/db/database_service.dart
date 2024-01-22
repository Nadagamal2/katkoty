import 'package:katkoty/packages/alarm/models/alarm_database_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:katkoty/db/models/database_model.dart';
import 'package:katkoty/models/ArticlesModelresponse.dart';
import 'package:katkoty/models/TaskModel.dart';
import 'package:katkoty/models/fadfada_model.dart';

class AppDatabase {
  AppDatabase? instance;
  static var DATABASE_NAME = "default_database.db";
  var DATABASE_VERSION = 1;
  static var ALARMS = "alarms";
  static var FADFADA_TABLE = "fadfada";
  static var TASKS_TABLE = "tasks";
  static var ARTICLES_TABLE = "articles";
  Database? database;

  static final AppDatabase _singleton = AppDatabase._internal();

  factory AppDatabase() {
    return _singleton;
  }

  AppDatabase._internal();

  Future<AppDatabase> initDb() async {
    print('open database');
    database ??= await openDatabase(
        join(await getDatabasesPath(), DATABASE_NAME),
        onCreate: (db, version) => createTables(db),
        version: DATABASE_VERSION,
        onUpgrade: (db, oldVersion, newVersion) => createTables(db),
      );
    return _singleton;
  }

  Future createTables(Database db) async {
    await db.execute(
      'CREATE TABLE $ALARMS (id INTEGER PRIMARY KEY AUTOINCREMENT, alarm_data TEXT)',
    );
    await db.execute(
      'CREATE TABLE ${TASKS_TABLE} (id INTEGER PRIMARY KEY AUTOINCREMENT, note TEXT, task TEXT)',
    );
    await db.execute(
      'CREATE TABLE ${FADFADA_TABLE} (id INTEGER PRIMARY KEY AUTOINCREMENT, note TEXT)',
    );
    await db.execute(
      'CREATE TABLE ${ARTICLES_TABLE} (id INTEGER UNIQUE, title TEXT, body TEXT, created_at TEXT)',
    );
  }

  Future<int> insert(DatabaseModel model) async {
    var id = await database!.insert(
      model.table()!,
      model.toMap()!,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('${model.table()} add successful');
    return id;
  }

  Future<void> update(DatabaseModel model) async {
    await database!.update(
      model.table()!,
      model.toMap()!,
      where: 'id = ?',
      whereArgs: [model.getId()!],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('model with id :  ${model.getId()} updated ');
    // database!.close();
  }

  Future<void> delete(DatabaseModel model) async {
    database!.delete(
      model.table()!,
      where: 'id = ?',
      whereArgs: [
        model.getId(),
      ],
    );
    // database!.close();
  }

  Future<List<AlarmDatabaseModel>> getAllAlarms() async {
    final List<Map<String, dynamic>> maps = await database!.query(ALARMS);
    List<AlarmDatabaseModel> data = [];
    for (var item in maps) {
      data.add(AlarmDatabaseModel.fromJson(item));
    }
    return data;
  }

  Future<List<TaskModel>> getAllTasks() async {
    final List<Map<String, dynamic>>? maps = await database!.query(TASKS_TABLE);
    List<TaskModel> data = [];
    for (var item in maps!) {
      data.add(TaskModel.fromJson(item));
    }
    return data;
  }

  Future<List<FadfadaModel>> getAllFadfada() async {
    final List<Map<String, dynamic>>? maps =
        await database!.query(FADFADA_TABLE);
    List<FadfadaModel> data = [];
    for (var item in maps!) {
      data.add(FadfadaModel.fromJson(item));
    }
    return data;
  }

  Future<List<Article>> getAllArticles() async {
    final List<Map<String, dynamic>>? maps =
        await database!.query(ARTICLES_TABLE);
    List<Article> data = [];
    for (var item in maps!) {
      data.add(Article.fromJson(item));
    }
    return data;
  }
}
