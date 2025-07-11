import 'package:flutter/material.dart';
import 'package:local_data_app/models/task.dart';
import 'package:local_data_app/services/database_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;
  TaskFilter _currentFilter = TaskFilter.all;

  List<Task> get tasks => _getFilteredTasks();
  bool get isLoading => _isLoading;
  String? get error => _error;
  TaskFilter get currentFilter => _currentFilter;

  List<Task> _getFilteredTasks() {
    switch (_currentFilter) {
      case TaskFilter.all:
        return _tasks;
      case TaskFilter.completed:
        return _tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.pending:
        return _tasks.where((task) => !task.isCompleted).toList();
    }
  }

  void setFilter(TaskFilter filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<void> loadTasks() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _tasks = await DatabaseService.instance.getAllTasks();
    } catch (e) {
      _setError('Failed to load tasks: ${e.toString()}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(Task task) async {
    try {
      _error = null;
      await DatabaseService.instance.insertTask(task);
      await loadTasks();
    } catch (e) {
      _setError('Failed to add task: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      _error = null;
      await DatabaseService.instance.updateTask(task);
      await loadTasks();
    } catch (e) {
      _setError('Failed to update task: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      _error = null;
      await DatabaseService.instance.deleteTask(id);
      await loadTasks();
    } catch (e) {
      _setError('Failed to delete task: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> toggleTaskStatus(Task task) async {
    try {
      _error = null;
      task.isCompleted = !task.isCompleted;
      await updateTask(task);
    } catch (e) {
      _setError('Failed to toggle task status: ${e.toString()}');
      rethrow;
    }
  }

  Future<void> saveTask(Task? existingTask) async {
    try {
      _error = null;
      final task = Task(
        id: existingTask?.id,
        title: existingTask?.title ?? '',
        description: existingTask?.description ?? '',
        isCompleted: existingTask?.isCompleted ?? false,
      );

      if (existingTask?.id == null) {
        await addTask(task);
      } else {
        await updateTask(task);
      }
    } catch (e) {
      _setError('Failed to save task: ${e.toString()}');
      rethrow;
    }
  }
}

enum TaskFilter { all, completed, pending }
