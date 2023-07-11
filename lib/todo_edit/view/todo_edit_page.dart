part of 'view.dart';

class TodoEditPage extends StatelessWidget {
  const TodoEditPage({super.key});

  static Route<void> route({Todo? todo}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => TodoEditBloc(
            // todoRepository: context.read<TodoRepository>(),
            // todo: todo,
            ),
        child: const TodoEditPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
