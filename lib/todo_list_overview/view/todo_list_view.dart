part of 'view.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'To Do Lists', profileButton: true),
      body: BlocListener<TodoListBloc, TodoListState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == TodoListStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Unexpected error occured')),
              );
          }
        },
        child: const TodoListsList(),
      ),
    );
  }
}
