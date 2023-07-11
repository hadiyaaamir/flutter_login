part of 'todo_edit_bloc.dart';

enum TodoEditStatus { initial, loading, success, failure }

extension TodoEditStatusX on TodoEditStatus {
  bool get isLoadingOrSuccess =>
      [TodoEditStatus.loading, TodoEditStatus.success].contains(this);
}

final class TodoEditState extends Equatable {
  const TodoEditState({
    this.status = TodoEditStatus.initial,
    this.todo,
    this.title = const StringInput.pure(),
    this.description = const StringInput.pure(),
    this.isValid = false,
  });

  final TodoEditStatus status;
  final Todo? todo;
  final StringInput title;
  final StringInput description;
  final bool isValid;

  bool get isNewTodo => todo == null;

  TodoEditState copyWith({
    TodoEditStatus? status,
    Todo? todo,
    StringInput? title,
    StringInput? description,
    bool? isValid,
  }) {
    return TodoEditState(
      status: status ?? this.status,
      todo: todo ?? this.todo,
      title: title ?? this.title,
      description: description ?? this.description,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [status, todo, title, description];
}
