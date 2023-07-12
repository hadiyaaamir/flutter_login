part of 'view.dart';

class TodoOverviewView extends StatelessWidget {
  const TodoOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'To Do List ', profileButton: true),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TodoOverviewBloc, TodoOverviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == TodosOverviewStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Unexpected error occured')),
                  );
              }
            },
          ),
          BlocListener<TodoOverviewBloc, TodoOverviewState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedTodo != current.lastDeletedTodo &&
                current.lastDeletedTodo != null,
            listener: (context, state) {
              final deletedTodo = state.lastDeletedTodo!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Failed to delete ${deletedTodo.title}'),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<TodoOverviewBloc>()
                            .add(const TodoOverviewUndoDelete());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: const TodoList(),
      ),
      floatingActionButton: BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
        builder: (context, state) {
          return Visibility(
            visible: state.todos.isNotEmpty,
            child: FloatingActionButton(
              onPressed: () => Navigator.push(context, TodoEditPage.route()),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
