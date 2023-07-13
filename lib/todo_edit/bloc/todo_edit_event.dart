part of 'todo_edit_bloc.dart';

sealed class TodoEditEvent extends Equatable {
  const TodoEditEvent();

  @override
  List<Object> get props => [];
}

final class TodoEditTitleChanged extends TodoEditEvent {
  const TodoEditTitleChanged({required this.title});

  final String title;

  @override
  List<Object> get props => [title];
}

final class TodoEditDescriptionChanged extends TodoEditEvent {
  const TodoEditDescriptionChanged({required this.description});

  final String description;

  @override
  List<Object> get props => [description];
}

final class TodoEditSubmitted extends TodoEditEvent {
  const TodoEditSubmitted();
}
