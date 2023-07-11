part of 'todo_overview_bloc.dart';

abstract class TodoOverviewState extends Equatable {
  const TodoOverviewState();
  
  @override
  List<Object> get props => [];
}

class TodoOverviewInitial extends TodoOverviewState {}
