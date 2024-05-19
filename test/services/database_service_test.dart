import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/app/models/task.dart';
import 'package:task_manager/services/database_service.dart';

void main() {
  group('DatabaseService', () {
    late DatabaseService databaseService;
    late http.Client httpClient;

    setUp(() {
      httpClient = http.Client();
      databaseService = DatabaseService(client: httpClient);
    });

    tearDown(() {
      httpClient.close();
    });

    test('getAllTodos should return a list of todos', () async {
      final todos = await databaseService.getAllTodos();
      expect(todos, isA<List<Todo>>());
    });

    test('getMoreTodos should return a list of todos', () async {
      const lastItemId = 10;
      final todos = await databaseService.getMoreTodos(lastItemId);
      expect(todos, isA<List<Todo>>());
    });

    test('getUserTodos should return a list of todos', () async {
      const userId = 1;
      final todos = await databaseService.getUserTodos(userId);
      expect(todos, isA<List<Todo>>());
    });

    test('addTodo should add a new todo', () async {
      const todo = Todo(
        id: 1,
        todo: 'New Todo',
        isCompleted: false,
        userId: 1,
      );
      final addedTodo = await databaseService.addTodo(todo);
      expect(addedTodo, equals(todo));
    });

    test('updateTodo should update a todo', () async {
      const todo = Todo(
        id: 1,
        todo: 'Updated Todo',
        isCompleted: true,
        userId: 1,
      );
      final updatedTodo = await databaseService.updateTodo(todo);
      expect(updatedTodo, equals(todo));
    });

    test('deleteTodo should delete a todo', () async {
      const todoId = 1;
      final isDeleted = await databaseService.deleteTodo(todoId);
      expect(isDeleted, isTrue);
    });
  });
}
