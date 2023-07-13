import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_repository/todo_repository.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc({
    required TodoRepository todoRepository,
    required String userId,
  })  : _todoRepository = todoRepository,
        _userId = userId,
        super(const TodoListState()) {
    on<TodoListSubscriptionRequested>(_onSubscriptionRequested);
    on<TodoListAdded>(_onListAdded);
  }

  final TodoRepository _todoRepository;
  final String _userId;

  Future<void> _onSubscriptionRequested(
    TodoListSubscriptionRequested event,
    Emitter<TodoListState> emit,
  ) async {
    emit(state.copyWith(status: () => TodoListStatus.loading));

    await emit.forEach<List<TodoList>>(
      _todoRepository.getTodoLists(userId: _userId),
      onData: (todolists) => state.copyWith(
        status: () => TodoListStatus.success,
        todoLists: () => todolists,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TodoListStatus.failure,
      ),
    );
  }

  Future<void> _onListAdded(
    TodoListAdded event,
    Emitter<TodoListState> emit,
  ) async {
    emit(state.copyWith(status: () => TodoListStatus.loading));

    final todoList = (TodoList(userId: _userId, title: ''));

    try {
      await _todoRepository.saveTodoList(todoList);
      emit(state.copyWith(status: () => TodoListStatus.success));
    } catch (e) {
      emit(state.copyWith(status: () => TodoListStatus.failure));
    }
  }
}
