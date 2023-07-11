import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_overview_event.dart';
part 'todo_overview_state.dart';

class TodoOverviewBloc extends Bloc<TodoOverviewEvent, TodoOverviewState> {
  TodoOverviewBloc() : super(TodoOverviewInitial()) {
    on<TodoOverviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
