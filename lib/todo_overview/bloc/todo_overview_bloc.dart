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

    if (event.isCompleted) {
      await _todoRepository.todoListIncrementCompleted(listId: todoList.id);
      await _todoRepository.todoListDecrementActive(listId: todoList.id);
    } else {
      await _todoRepository.todoListDecrementCompleted(listId: todoList.id);
      await _todoRepository.todoListIncrementActive(listId: todoList.id);
    }
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

      event.todo.isCompleted
          ? await _todoRepository.todoListDecrementCompleted(
              listId: todoList.id)
          : await _todoRepository.todoListDecrementActive(listId: todoList.id);

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

      deletedTodo.isCompleted
          ? await _todoRepository.todoListIncrementCompleted(
              listId: todoList.id)
          : await _todoRepository.todoListIncrementActive(listId: todoList.id);
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
    int completed = await _todoRepository.toggleCompleteAll(
        isCompleted: !areAllCompleted, listId: todoList.id);

    if (areAllCompleted) {
      await _todoRepository.todoListSetCompleted(value: 0, listId: todoList.id);
      await _todoRepository.todoListSetActive(
          value: completed, listId: todoList.id);
    } else {
      await _todoRepository.todoListSetCompleted(
          value: completed, listId: todoList.id);
      await _todoRepository.todoListSetActive(value: 0, listId: todoList.id);
    }
  }

  Future<void> _onClearCompleted(
    TodoOverviewClearCompleted event,
    Emitter<TodoOverviewState> emit,
  ) async {
    int cleared = await _todoRepository.clearCompleted(listId: todoList.id);
    await _todoRepository.todoListDecrementCompleted(
        listId: todoList.id, value: cleared);
    // final newTodoList = state.todoList.copyWith(
    //   completedItems: state.todoList.completedItems - cleared,
    // );
    // await _todoRepository.saveTodoList(newTodoList);
  }
}
