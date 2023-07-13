part of 'view.dart';

class TodoEditPage extends StatelessWidget {
  const TodoEditPage({super.key, required this.todoList});

  final TodoList todoList;

  static Route<void> route({Todo? todo, required TodoList todoList}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => TodoEditBloc(
          todoRepository: context.read<TodoRepository>(),
          todoList: todoList,
          todo: todo,
        ),
        child: TodoEditPage(todoList: todoList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoEditBloc, TodoEditState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == TodoEditStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const TodoEditView(),
    );
  }
}
