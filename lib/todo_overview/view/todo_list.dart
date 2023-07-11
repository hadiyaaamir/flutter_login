part of 'view.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
      builder: (context, state) {
        if (state.todos.isEmpty) {
          return (state.status == TodosOverviewStatus.loading)
              ? const Center(child: CircularProgressIndicator())
              : (state.status != TodosOverviewStatus.success)
                  ? const SizedBox()
                  : const Center(child: Text('Your List is Empty'));
        }
        return ListView(
          children: [
            for (final todo in state.filteredTodos)
              // for (int i = 0; i < 2; i++)
              TodoListTile(
                // todo: Todo(title: 'Hello no.$i', userId: ''),
                todo: todo,
                onTap: () {},
                onDismissed: (_) {
                  context
                      .read<TodoOverviewBloc>()
                      .add(TodoOverviewDeleted(todo: todo));
                },
                onToggleCompleted: (isCompleted) {
                  context.read<TodoOverviewBloc>().add(
                        TodoOverviewCompletionToggled(
                          todo: todo,
                          isCompleted: isCompleted,
                        ),
                      );
                },
              )
          ],
        );
      },
    );
  }
}
