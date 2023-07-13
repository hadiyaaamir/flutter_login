part of 'todo_list_bloc.dart';

enum TodoListStatus { initial, loading, success, failure }

final class TodoListState extends Equatable {
  const TodoListState({
    this.status = TodoListStatus.initial,
    this.todoLists = const [],
    this.currentList,
  });

  final TodoListStatus status;
  final List<TodoList> todoLists;
  final TodoList? currentList;

  TodoListState copyWith({
    TodoListStatus Function()? status,
    List<TodoList> Function()? todoLists,
    TodoList? currentList,
  }) {
    return TodoListState(
      status: status != null ? status() : this.status,
      todoLists: todoLists != null ? todoLists() : this.todoLists,
      currentList: currentList ?? this.currentList,
    );
  }

  @override
  List<Object?> get props => [status, todoLists, currentList];
}
