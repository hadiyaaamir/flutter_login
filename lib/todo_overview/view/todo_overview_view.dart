part of 'view.dart';

class TodoOverviewView extends StatelessWidget {
  const TodoOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final String title =
        context.select((TodoOverviewBloc bloc) => bloc.todoList.title);

    return Scaffold(
      appBar: CustomAppBar(title: title, profileButton: true),
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
                    content: Text('Deleted ${deletedTodo.title}'),
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
        child: const TodosList(),
      ),
      floatingActionButton: BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
        builder: (context, state) {
          final TodoList todoList =
              context.select((TodoOverviewBloc bloc) => bloc.todoList);

          return Visibility(
            visible: state.todos.isNotEmpty,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              onPressed: () => Navigator.push(
                  context, TodoEditPage.route(todoList: todoList)),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
