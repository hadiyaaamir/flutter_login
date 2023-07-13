part of 'widgets.dart';

enum TodoOverviewOption { toggleAll, clearCompleted }

class TodoOptionsMenu extends StatelessWidget {
  const TodoOptionsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final todos =
        context.select((TodoOverviewBloc bloc) => bloc.state.filteredTodos);
    final hasTodos = todos.isNotEmpty;
    final completedTodos = todos.where((todo) => todo.isCompleted).length;

    return PopupMenuButton<TodoOverviewOption>(
      child: const Padding(
        padding: EdgeInsets.only(left: 15),
        child: Icon(Icons.more_vert),
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: TodoOverviewOption.toggleAll,
            enabled: hasTodos,
            child: Text(
              completedTodos == todos.length
                  ? 'Mark All as Incomplete'
                  : 'Mark All as Complete',
            ),
          ),
          PopupMenuItem(
            value: TodoOverviewOption.clearCompleted,
            enabled: hasTodos && completedTodos > 0,
            child: const Text('Clear Completed'),
          ),
        ];
      },
      onSelected: (options) {
        switch (options) {
          case TodoOverviewOption.toggleAll:
            context.read<TodoOverviewBloc>().add(const TodoOverviewToggleAll());
          case TodoOverviewOption.clearCompleted:
            context
                .read<TodoOverviewBloc>()
                .add(const TodoOverviewClearCompleted());
        }
      },
    );
  }
}
