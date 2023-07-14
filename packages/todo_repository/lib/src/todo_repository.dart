import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/model.dart';

part 'todo_repository_firebase.dart';

abstract class TodoRepository {
  const TodoRepository();

  Stream<List<TodoList>> getTodoLists({required String userId});
  Stream<List<Todo>> getTodos({required String listId});

  Future<void> saveTodoList(TodoList todoList);
  Future<void> saveTodo(Todo todo);

  Future<void> deleteTodoList(String id);
  Future<void> deleteTodo(String id);

  Future<int> clearCompleted({required String listId});
  Future<int> toggleCompleteAll(
      {required bool isCompleted, required String listId});

  Future<void> todoListIncrementCompleted(
      {int value = 1, required String listId});
  Future<void> todoListDecrementCompleted(
      {int value = 1, required String listId});
  Future<void> todoListSetCompleted(
      {required int value, required String listId});

  Future<void> todoListIncrementActive({int value = 1, required String listId});
  Future<void> todoListDecrementActive({int value = 1, required String listId});
  Future<void> todoListSetActive({required int value, required String listId});
}

class TodoNotFoundException implements Exception {}

class TodoListNotFoundException implements Exception {}
