import 'package:todo_repository/todo_repository.dart';

enum TodoViewFilter { all, activeOnly, completedOnly }

extension TodosViewFilterX on TodoViewFilter {
  bool apply(Todo todo) {
    switch (this) {
      case TodoViewFilter.all:
        return true;
      case TodoViewFilter.activeOnly:
        return !todo.isCompleted;
      case TodoViewFilter.completedOnly:
        return todo.isCompleted;
    }
  }

  String get text {
    switch (this) {
      case TodoViewFilter.all:
        return 'All';
      case TodoViewFilter.activeOnly:
        return 'Active';
      case TodoViewFilter.completedOnly:
        return 'Completed';
    }
  }

  Iterable<Todo> applyAll(Iterable<Todo> todos) {
    return todos.where(apply);
  }
}
