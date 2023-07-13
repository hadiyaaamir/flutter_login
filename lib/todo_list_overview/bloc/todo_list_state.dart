part of 'todo_list_bloc.dart';

enum TodoListStatus { initial, loading, success, failure }

final class TodoListState extends Equatable {
  const TodoListState({
    this.status = TodoListStatus.initial,
    this.todoLists = const [],
    this.title = const StringInput.pure(allowEmpty: true),
  });

  final TodoListStatus status;
  final List<TodoList> todoLists;
  final StringInput title;

  TodoListState copyWith({
    TodoListStatus Function()? status,
    List<TodoList> Function()? todoLists,
    StringInput? title,
  }) {
    return TodoListState(
      status: status != null ? status() : this.status,
      todoLists: todoLists != null ? todoLists() : this.todoLists,
      title: title ?? this.title,
    );
  }

  @override
  List<Object> get props => [status, todoLists, title];
}
