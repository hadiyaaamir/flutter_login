import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/model.dart';

part 'todo_repository_firebase.dart';

abstract class TodoRepository {
  const TodoRepository();

  Stream<List<Todo>> getTodos();

  Future<void> saveTodo(Todo todo);

  /// Deletes the `todo` with the given id.
  ///
  /// If no `todo` with the given id exists, a [TodoNotFoundException] error is
  /// thrown.
  Future<void> deleteTodo(String id);

  /// Deletes all completed todos.
  ///
  /// Returns the number of deleted todos.
  Future<int> clearCompleted();

  /// Sets the `isCompleted` state of all todos to the given value.
  ///
  /// Returns the number of updated todos.
  Future<int> completeAll({required bool isCompleted});
}

/// Error thrown when a [Todo] with a given id is not found.
class TodoNotFoundException implements Exception {}
