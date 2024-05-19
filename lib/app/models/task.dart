// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todo {
  final int id;
  final String todo;
  final bool isCompleted;
  final int userId;
  final bool isDeleted;

  const Todo({
    required this.id,
    required this.todo,
    this.isCompleted = false,
    required this.userId,
    this.isDeleted = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'todo': todo,
      'completed': isCompleted,
      'userId': userId,
      'isDeleted': isDeleted,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int,
      todo: map['todo'] as String,
      isCompleted: map['completed'] as bool,
      userId: map['userId'] as int,
      isDeleted: (map['isDeleted'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  Todo copyWith({
    int? id,
    String? todo,
    bool? isCompleted,
    int? userId,
    bool? isDeleted,
  }) {
    return Todo(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      isCompleted: isCompleted ?? this.isCompleted,
      userId: userId ?? this.userId,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
