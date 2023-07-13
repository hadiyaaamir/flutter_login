part of 'todo_list_bloc.dart';

sealed class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

final class TodoListSubscriptionRequested extends TodoListEvent {
  const TodoListSubscriptionRequested();
}

final class TodoListAdded extends TodoListEvent {
  const TodoListAdded();
}
