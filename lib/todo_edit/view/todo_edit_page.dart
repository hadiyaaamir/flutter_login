part of 'view.dart';

class TodoEditPage extends StatelessWidget {
  const TodoEditPage({super.key});

  static Route<void> route({Todo? todo}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => TodoEditBloc(
          todoRepository: context.read<TodoRepository>(),
          userId: context.read<AuthenticationRepository>().currentAuthUser!.uid,
          todo: todo,
        ),
        child: const TodoEditPage(),
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
