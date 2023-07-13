part of 'todo_list_bloc.dart';

enum TodoListStatus { initial, loading, success, failure }

final class TodoListState extends Equatable {
  const TodoListState({
    this.status = TodoListStatus.initial,
    this.todoLists = const [],
  });

  final TodoListStatus status;
  final List<TodoList> todoLists;

  TodoListState copyWith({
    TodoListStatus Function()? status,
    List<TodoList> Function()? todoLists,
  }) {
    return TodoListState(
      status: status != null ? status() : this.status,
      todoLists: todoLists != null ? todoLists() : this.todoLists,
    );
  }

  @override
  List<Object> get props => [status, todoLists];
}
