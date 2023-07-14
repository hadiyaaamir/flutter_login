import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:todo_repository/todo_repository.dart';

part 'todo_edit_event.dart';
part 'todo_edit_state.dart';

class TodoEditBloc extends Bloc<TodoEditEvent, TodoEditState> {
  TodoEditBloc({
    required TodoRepository todoRepository,
    required Todo? todo,
    required this.todoList,
  })  : _todoRepository = todoRepository,
        super(
          TodoEditState(
            todo: todo,
            title: StringInput.dirty(value: todo?.title ?? ''),
            description: StringInput.dirty(
              value: todo?.description ?? '',
              allowEmpty: true,
            ),
          ),
        ) {
    on<TodoEditTitleChanged>(_onTitleChanged);
    on<TodoEditDescriptionChanged>(_onDescriptionChanged);
    on<TodoEditSubmitted>(_onSubmitted);
  }

  final TodoRepository _todoRepository;
  final TodoList todoList;

  Future<void> _onTitleChanged(
    TodoEditTitleChanged event,
    Emitter<TodoEditState> emit,
  ) async {
    final title = StringInput.dirty(value: event.title);
    emit(
      state.copyWith(
        title: title,
        isValid: Formz.validate([title, state.description]),
      ),
    );
  }

  Future<void> _onDescriptionChanged(
    TodoEditDescriptionChanged event,
    Emitter<TodoEditState> emit,
  ) async {
    final description = StringInput.dirty(
      value: event.description,
      allowEmpty: true,
    );
    emit(
      state.copyWith(
        description: description,
        isValid: Formz.validate([state.title, description]),
      ),
    );
  }

  Future<void> _onSubmitted(
    TodoEditSubmitted event,
    Emitter<TodoEditState> emit,
  ) async {
    emit(state.copyWith(status: TodoEditStatus.loading));

    final todo = (state.todo ?? Todo(title: '', listId: todoList.id)).copyWith(
      title: state.title.value,
      description: state.description.value,
    );

    try {
      await _todoRepository.saveTodo(todo);
      emit(state.copyWith(status: TodoEditStatus.success));
    } catch (e) {
      emit(state.copyWith(status: TodoEditStatus.failure));
    }
  }
}
