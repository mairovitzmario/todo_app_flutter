import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/logic/models/to_do_list_model.dart';
import 'package:todo/logic/providers/to_do_lists_provider.dart';

class ToDoDatabase {
  static final ToDoDatabase instance = ToDoDatabase._internal();
  static Database? _database;

  ToDoDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute("""
      CREATE TABLE todo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        date INTEGER NOT NULL,
        list TEXT NOT NULL
      )
    """);
  }

  // Method to insert a ToDoList into the database
  Future<ToDoListModel> insertList(ToDoListModel toDoList) async {
    final db = await instance.database;
    // Insert the ToDoList into the database and get the generated id.
    final id = await db.insert('todo', toDoList.serializeModel());

    return toDoList.copy(id: id);
  }

  // Method to update an existing ToDoList in the database
  Future<int> updateList(int id, ToDoListModel newToDoList) async {
    final db = await instance.database;
    // Update the ToDoList and return the number of affected rows.

    if (newToDoList == null) {
      return -1;
    }

    return await db.update(
      'todo',
      newToDoList.serializeModel(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Method to delete a ToDoList from the database
  Future<int> deleteList(int id) async {
    final db = await instance.database;
    // Delete the ToDoList and return the number of affected rows.
    return await db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Optionally, you can add methods to retrieve lists from the database.
  Future<List<ToDoListModel>> getAllToDoLists() async {
    final db = await instance.database;
    final result = await db.query('todo');
    return result.map((json) => ToDoListModel.fromJson(json)).toList();
  }

  Future<ToDoListModel?> getToDoListById(int id) async {
    final db = await instance.database;
    final result = await db.query('todo', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return ToDoListModel.fromJson(result.first);
    }
    return null;
  }
}
