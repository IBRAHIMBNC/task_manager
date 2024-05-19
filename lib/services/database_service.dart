import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/app/models/task.dart';

class DatabaseService {
  static const String _todosEndpoint = 'https://dummyjson.com/todos';
  static const String _userTodosEndpoint = 'https://dummyjson.com/todos/user';
  static const String _addTodoEndpoint = 'https://dummyjson.com/todos/add';
  final http.Client client;
  DatabaseService({required this.client});

  // Get all todos
  Future<List<Todo>> getAllTodos() async {
    final response = await http.get(Uri.parse(_todosEndpoint));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<dynamic> data = (responseBody['todos']);
      return data.map((e) => Todo.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  // Get more todos for pagination
  Future<List<Todo>> getMoreTodos(int lastItemId) async {
    final response =
        await http.get(Uri.parse('$_todosEndpoint?limit=10&skip=$lastItemId'));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final List<dynamic> data = (responseBody['todos']);
      return data.map((e) => Todo.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  // Get user todos added by the user
  Future<List<Todo>> getUserTodos(int userId) async {
    final response = await http.get(Uri.parse('$_userTodosEndpoint/$userId'));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final List<dynamic> data = (responseBody['todos']);
      return data.map((e) => Todo.fromMap(e)).toList();
    } else {
      return [];
    }
  }

  // Add a new todo
  Future<Todo> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse(_addTodoEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(todo.toMap()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      debugPrint('Todo added successfully response: $data');
      return todo;
    } else {
      debugPrint('Failed to add todo');
      throw Exception('Failed to add todo');
    }
  }

  // Update a todo
  Future<Todo> updateTodo(Todo todo) async {
    final response = await http.put(
      Uri.parse('$_todosEndpoint/1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"completed": todo.isCompleted}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      debugPrint('Todo updated successfully response: $data');
      return todo;
    } else {
      debugPrint('Failed to update todo');
      throw Exception('Failed to update todo');
    }
  }

  // Delete a todo
  Future<bool> deleteTodo(int todoId) async {
    final response = await http.delete(Uri.parse('$_todosEndpoint/1'));
    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint('Failed to delete todo');
      return false;
    }
  }
}
