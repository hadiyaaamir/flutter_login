part of 'todo_list_bloc.dart';

sealed class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

final class TodoListSubscriptionRequested extends TodoListEvent {
  const TodoListSubscriptionRequested();
}

final class TodoListTitleChanged extends TodoListEvent {
  const TodoListTitleChanged({required this.title});

  final String title;

  @override
  List<Object> get props => [title];
}

final class TodoListAdded extends TodoListEvent {
  const TodoListAdded();
}

final class TodoListDeleted extends TodoListEvent {
  const TodoListDeleted({required this.todoList});

  final TodoList todoList;

  @override
  List<Object> get props => [todoList];
}

final class TodoListUndoDelete extends TodoListEvent {
  const TodoListUndoDelete();
}
