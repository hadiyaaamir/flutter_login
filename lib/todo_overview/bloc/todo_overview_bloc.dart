import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_repository/todo_repository.dart';

part 'todo_overview_event.dart';
part 'todo_overview_state.dart';

class TodoOverviewBloc extends Bloc<TodoOverviewEvent, TodoOverviewState> {
  TodoOverviewBloc() : super(const TodoOverviewState()) {
    on<TodoOverviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
