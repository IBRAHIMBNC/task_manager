import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/app/models/task.dart';
import 'package:task_manager/services/database_service.dart';
import 'package:task_manager/services/local_storage_service.dart';

class AppStateService with ListenableServiceMixin {
  final _databaseService = locator<DatabaseService>();
  final _localStorageService = locator<LocalStorageService>();
  final List<Todo> _allTasks = [];

  final List<Todo> _myTasks = [];
  List<Todo> get allTasks => _allTasks;
  List<Todo> get myTasks => _myTasks;

  AppStateService() {
    init();
  }

  init() async {
    await fetchAllTasks();
    await fetchMyTasks();
  }

  Future<void> fetchAllTasks() async {
    _allTasks.clear();
    final result = await _databaseService.getAllTodos();
    _allTasks.addAll(result);
    _allTasks.sort((a, b) => a.id.compareTo(b.id));
    notifyListeners();
  }

  Future<void> fetchMoreTasks(int lastItemId) async {
    final result = await _databaseService.getMoreTodos(lastItemId);
    _allTasks.addAll(result);
    _allTasks.sort((a, b) => a.id.compareTo(b.id));
    notifyListeners();
  }

  Future<void> fetchMyTasks() async {
    _myTasks.clear();
    final result = _localStorageService.getTasks();
    _myTasks.addAll(result);
    notifyListeners();
  }

  void addTask(Todo task) async {
    final newTask = await _databaseService.addTodo(task);
    _myTasks.add(task);
    _localStorageService.addTask(newTask).then((value) {
      debugPrint('Task added to local storage with id: ${task.id}');
    });
    notifyListeners();
  }

  Future<bool> removeTask(int taskId) async {
    final result = await _databaseService.deleteTodo(taskId);
    if (result) {
      _myTasks.removeWhere((element) => element.id == taskId);
      _localStorageService.deleteTask(taskId).then((value) {
        debugPrint('Task removed from local storage');
      });
      notifyListeners();
      return result;
    }
    return false;
  }

  void updateTask(Todo task) async {
    final index = _myTasks.indexWhere((element) => element.id == task.id);
    _myTasks[index] = task;
    notifyListeners();
    final updatedTask = await _databaseService.updateTodo(task);
    _localStorageService.updateTask(updatedTask).then((value) {
      debugPrint('Task updated in local storage');
    });
  }
}
