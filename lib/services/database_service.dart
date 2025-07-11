import 'package:local_data_app/models/task.dart';
import 'package:local_data_app/utils/database_helper.dart';

class DatabaseService {
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  Future<int> insertTask(Task task) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getAllTasks() async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query('tasks', orderBy: 'created_at DESC');
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  Future<int> updateTask(Task task) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await DatabaseHelper.instance.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
