part of 'view.dart';

class TodosList extends StatelessWidget {
  const TodosList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoOverviewBloc, TodoOverviewState>(
      builder: (context, state) {
        if (state.todos.isEmpty) {
          return (state.status == TodosOverviewStatus.loading)
              ? const Center(child: CircularProgressIndicator())
              : (state.status != TodosOverviewStatus.success)
                  ? const SizedBox()
                  : const _EmptyList();
        }
        return const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TodoFilterOptions(), TodoOptionsMenu()],
            ),
            _NonEmptyList(),
          ],
        );
      },
    );
  }
}

class _NonEmptyList extends StatelessWidget {
  const _NonEmptyList();

  @override
  Widget build(BuildContext context) {
    final Iterable<Todo> filteredTodos =
        context.select((TodoOverviewBloc bloc) => bloc.state.filteredTodos);

    final TodosOverviewStatus status =
        context.select((TodoOverviewBloc bloc) => bloc.state.status);

    final TodoList todoList =
        context.select((TodoOverviewBloc bloc) => bloc.todoList);

    return Expanded(
      child: status == TodosOverviewStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : Scrollbar(
              radius: const Radius.circular(20),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      Todo todo = filteredTodos.elementAt(index);
                      return TodoListTile(
                        todo: todo,
                        onTap: () {
                          Navigator.push(
                            context,
                            TodoEditPage.route(todo: todo, todoList: todoList),
                          );
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
                      );
                    }),
              ),
            ),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    final TodoList todoList =
        context.select((TodoOverviewBloc bloc) => bloc.todoList);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Your List is Empty'),
          const SizedBox(height: 10),
          Button(
            label: 'Add To Do',
            width: 130,
            onPressed: () {
              Navigator.push(context, TodoEditPage.route(todoList: todoList));
            },
          )
        ],
      ),
    );
  }
}
