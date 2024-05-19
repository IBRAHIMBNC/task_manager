import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/app/models/task.dart';

class LocalStorageService {
  static SharedPreferences? _preferences;
  SharedPreferences get prefs => _preferences!;
  static const String _tasksKey = 'tasks';
  static const String _userTokenKey = 'currentUserToken';
  static const String _expiryTimeKey = 'expiryTime';

  LocalStorageService() {
    init();
  }
  String? get authToken => _preferences!.getString(_userTokenKey);
  DateTime? get expiryTime {
    final expiryTimeString = _preferences!.getString(_expiryTimeKey);
    if (expiryTimeString != null) {
      return DateTime.parse(expiryTimeString);
    }
    return null;
  }

  // Initialize the shared preferences
  Future<void> init() async {
    debugPrint('Local Storage Service Initialized');
    _preferences = await SharedPreferences.getInstance();
    // _preferences!.clear();
  }

  // Save the token and expiry time in the shared preferences
  saveSession(String token, int minutes) {
    _preferences!.setString(_userTokenKey, token);
    final expiryTime = DateTime.now().add(Duration(minutes: minutes));
    _preferences!.setString(_expiryTimeKey, expiryTime.toIso8601String());
  }

  // Delete the token from the shared preferences
  deleteToken() {
    _preferences!.remove(_userTokenKey);
  }

  static addString(String key, String value) {
    _preferences!.setString(key, value);
  }

  // Add a task to the shared preferences
  Future<bool> addTask(
    Todo task,
  ) {
    final value = task.toJson();
    final List<String> tasks = _preferences!.getStringList(_tasksKey) ?? [];
    tasks.add(value);
    return _preferences!.setStringList(_tasksKey, tasks);
  }

// Get a task from the shared preferences
  Todo getTask(int id) {
    final List<String> jsonData = _preferences!.getStringList(_tasksKey) ?? [];
    final tasks = jsonData.map((element) => Todo.fromJson(element)).toList();

    return tasks.firstWhere((element) => element.id == id);
  }

  // Update a task in the shared preferences
  Future<bool> updateTask(Todo task) {
    final List<String> jsonData = _preferences!.getStringList(_tasksKey) ?? [];
    final tasks = jsonData.map((element) => Todo.fromJson(element)).toList();
    final index = tasks.indexWhere((element) => element.id == task.id);
    tasks[index] = task;
    final updatedTasks = tasks.map((e) => e.toJson()).toList();
    return _preferences!.setStringList(_tasksKey, updatedTasks);
  }

// Delete a task from the shared preferences
  Future<bool> deleteTask(int id) {
    final List<String> jsonData = _preferences!.getStringList(_tasksKey) ?? [];
    final tasks = jsonData.map((element) => Todo.fromJson(element)).toList();
    final index = tasks.indexWhere((element) => element.id == id);
    tasks.removeAt(index);
    final updatedTasks = tasks.map((e) => e.toJson()).toList();
    return _preferences!.setStringList(_tasksKey, updatedTasks);
  }

  // Get all tasks from the shared preferences
  List<Todo> getTasks() {
    final List<String> jsonData = _preferences!.getStringList(_tasksKey) ?? [];
    return jsonData.map((element) => Todo.fromJson(element)).toList();
  }
}
