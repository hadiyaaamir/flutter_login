part of 'todo_overview_bloc.dart';

sealed class TodoOverviewEvent extends Equatable {
  const TodoOverviewEvent();

  @override
  List<Object> get props => [];
}

final class TodoOverviewSubscriptionRequested extends TodoOverviewEvent {
  const TodoOverviewSubscriptionRequested();
}

final class TodoOverviewCompletionToggled extends TodoOverviewEvent {
  const TodoOverviewCompletionToggled({
    required this.todo,
    required this.isCompleted,
  });

  final Todo todo;
  final bool isCompleted;

  @override
  List<Object> get props => [todo, isCompleted];
}

final class TodoOverviewDeleted extends TodoOverviewEvent {
  const TodoOverviewDeleted({required this.todo});

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

final class TodoOverviewUndoDelete extends TodoOverviewEvent {
  const TodoOverviewUndoDelete();
}

//TODO: change this to filter thing when created filter
final class TodoOverviewFilterChanged extends TodoOverviewEvent {
  const TodoOverviewFilterChanged({required this.todo});

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

final class TodoOverviewToggleAll extends TodoOverviewEvent {
  const TodoOverviewToggleAll();
}

final class TodoOverviewClearCompleted extends TodoOverviewEvent {
  const TodoOverviewClearCompleted();
}
