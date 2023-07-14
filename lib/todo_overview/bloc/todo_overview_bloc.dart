import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login/todo_overview/model/model.dart';
import 'package:todo_repository/todo_repository.dart';

part 'todo_overview_event.dart';
part 'todo_overview_state.dart';

class TodoOverviewBloc extends Bloc<TodoOverviewEvent, TodoOverviewState> {
  TodoOverviewBloc({
    required TodoRepository todoRepository,
    required this.todoList,
  })  : _todoRepository = todoRepository,
        super(const TodoOverviewState()) {
    on<TodoOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<TodoOverviewCompletionToggled>(_onTodoCompletionToggled);
    on<TodoOverviewDeleted>(_onTodoDeleted);
    on<TodoOverviewUndoDelete>(_onUndoDelete);
    on<TodoOverviewFilterChanged>(_onFilterChanged);
    on<TodoOverviewToggleAll>(_onToggleAll);
    on<TodoOverviewClearCompleted>(_onClearCompleted);
  }

  final TodoRepository _todoRepository;
  final TodoList todoList;

  Future<void> _onSubscriptionRequested(
    TodoOverviewSubscriptionRequested event,
    Emitter<TodoOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => TodosOverviewStatus.loading));

    await emit.forEach<List<Todo>>(
      _todoRepository.getTodos(listId: todoList.id),
      onData: (todos) => state.copyWith(
        status: () => TodosOverviewStatus.success,
        todos: () => todos,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TodosOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onTodoCompletionToggled(
    TodoOverviewCompletionToggled event,
    Emitter<TodoOverviewState> emit,
  ) async {
    final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await _todoRepository.saveTodo(newTodo);
  }

  Future<void> _onTodoDeleted(
    TodoOverviewDeleted event,
    Emitter<TodoOverviewState> emit,
  ) async {
    emit(
      state.copyWith(
        lastDeletedTodo: () => event.todo,
        status: () => TodosOverviewStatus.loading,
      ),
    );
    try {
      await _todoRepository.deleteTodo(event.todo.id);
      emit(state.copyWith(status: () => TodosOverviewStatus.success));
    } catch (_) {
      emit(state.copyWith(status: () => TodosOverviewStatus.failure));
    }
  }

  Future<void> _onUndoDelete(
    TodoOverviewUndoDelete event,
    Emitter<TodoOverviewState> emit,
  ) async {
    if (state.lastDeletedTodo != null) {
      final deletedTodo = state.lastDeletedTodo!;
      emit(state.copyWith(lastDeletedTodo: () => null));
      await _todoRepository.saveTodo(deletedTodo);
    }
  }

  Future<void> _onFilterChanged(
    TodoOverviewFilterChanged event,
    Emitter<TodoOverviewState> emit,
  ) async {
    emit(state.copyWith(filter: () => event.filter));
  }

  Future<void> _onToggleAll(
    TodoOverviewToggleAll event,
    Emitter<TodoOverviewState> emit,
  ) async {
    final areAllCompleted = state.todos.every((todo) => todo.isCompleted);
    await _todoRepository.toggleCompleteAll(isCompleted: !areAllCompleted);
  }

  Future<void> _onClearCompleted(
    TodoOverviewClearCompleted event,
    Emitter<TodoOverviewState> emit,
  ) async {
    await _todoRepository.clearCompleted();
  }
}
