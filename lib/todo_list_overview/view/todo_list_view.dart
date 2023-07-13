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
      floatingActionButton: const _AddTodoListButton(),
    );
  }
}

class _AddTodoListButton extends StatelessWidget {
  const _AddTodoListButton();

  @override
  Widget build(BuildContext context) {
    final todoListBloc = BlocProvider.of<TodoListBloc>(context);

    return BlocBuilder<TodoListBloc, TodoListState>(
      builder: (context, state) {
        return FloatingActionIconButton(
          isVisible: state.todoLists.isNotEmpty,
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AddListDialog(todoListBloc: todoListBloc),
          ),
        );
      },
    );
  }
}
