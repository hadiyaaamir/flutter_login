import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_edit_event.dart';
part 'todo_edit_state.dart';

class TodoEditBloc extends Bloc<TodoEditEvent, TodoEditState> {
  TodoEditBloc() : super(TodoEditInitial()) {
    on<TodoEditEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
