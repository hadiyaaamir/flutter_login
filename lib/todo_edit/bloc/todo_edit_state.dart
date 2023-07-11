part of 'todo_edit_bloc.dart';

abstract class TodoEditState extends Equatable {
  const TodoEditState();
  
  @override
  List<Object> get props => [];
}

class TodoEditInitial extends TodoEditState {}
