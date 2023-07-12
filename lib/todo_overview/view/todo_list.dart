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
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Your List is Empty'),
                          const SizedBox(height: 10),
                          Button(
                              onPressed: () {
                                Navigator.push(context, TodoEditPage.route());
                              },
                              label: 'Add To Do',
                              width: 130)
                        ],
                      ),
                    );
        }
        return ListView(
          children: [
            for (final todo in state.filteredTodos)
              // for (int i = 0; i < 2; i++)
              TodoListTile(
                // todo: Todo(title: 'Hello no.$i', userId: ''),
                todo: todo,
                onTap: () {
                  Navigator.push(context, TodoEditPage.route(todo: todo));
                },
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
              ),
          ],
        );
      },
    );
  }
}
