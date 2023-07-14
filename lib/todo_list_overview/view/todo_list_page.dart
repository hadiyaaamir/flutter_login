part of 'view.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const TodoListPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoListBloc(
        userId: context.read<AuthenticationRepository>().currentAuthUser!.id,
        todoRepository: context.read<TodoRepository>(),
      )..add(const TodoListSubscriptionRequested()),
      child: const TodoListView(),
    );
  }
}
