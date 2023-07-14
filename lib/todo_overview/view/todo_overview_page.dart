part of 'view.dart';

class TodoOverviewPage extends StatelessWidget {
  const TodoOverviewPage({super.key, required this.todoList});

  final TodoList todoList;

  static Route<void> route({required TodoList todoList}) {
    return MaterialPageRoute<void>(
      builder: (_) => TodoOverviewPage(todoList: todoList),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoOverviewBloc(
        todoList: todoList,
        todoRepository: context.read<TodoRepository>(),
      )..add(const TodoOverviewSubscriptionRequested()),
      child: const TodoOverviewView(),
    );
  }
}
