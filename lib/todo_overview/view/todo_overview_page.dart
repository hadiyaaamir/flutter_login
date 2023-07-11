part of 'view.dart';

class TodoOverviewPage extends StatelessWidget {
  const TodoOverviewPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const TodoOverviewPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoOverviewBloc(
        userId: context.read<AuthenticationRepository>().currentAuthUser!.uid,
        todoRepository: context.read<TodoRepository>(),
      )..add(const TodoOverviewSubscriptionRequested()),
      child: const TodoOverviewView(),
    );
  }
}
