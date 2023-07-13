part of 'todo_list_bloc.dart';

sealed class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

final class TodoListSubscriptionRequested extends TodoListEvent {
  const TodoListSubscriptionRequested();
}

final class TodoListCurrentListChanged extends TodoListEvent {
  const TodoListCurrentListChanged({required this.currentList});

  final TodoList currentList;

  @override
  List<Object> get props => [currentList];
}

final class TodoListAdded extends TodoListEvent {
  const TodoListAdded();
}
