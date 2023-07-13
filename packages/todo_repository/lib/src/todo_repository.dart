import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/model.dart';

part 'todo_repository_firebase.dart';

abstract class TodoRepository {
  const TodoRepository();

  Stream<List<TodoList>> getTodoLists({required String userId});

  Stream<List<Todo>> getTodos({required String listId});

  Future<void> saveTodo(Todo todo);

  Future<void> deleteTodo(String id);

  Future<int> clearCompleted();

  Future<int> toggleCompleteAll({required bool isCompleted});
}

/// Error thrown when a [Todo] with a given id is not found.
class TodoNotFoundException implements Exception {}
