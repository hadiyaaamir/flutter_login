part of 'widget.dart';

class ListListTile extends StatelessWidget {
  const ListListTile(
      {super.key, required this.todoList, required this.onDismissed});

  final TodoList todoList;
  final DismissDirectionCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    final status = context.read<TodoListBloc>().state.status;

    final totalItems = todoList.activeItems + todoList.completedItems;
    final String progress = totalItems == 0
        ? ''
        : '${((todoList.completedItems.toDouble() / totalItems.toDouble()) * 100).toStringAsFixed(1)}%';

    return Dismissible(
      key: Key('todoListListTile_dismissible_${todoList.id}'),
      onDismissed: status == TodoListStatus.loading ? null : onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.delete, color: Theme.of(context).colorScheme.onError),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Card(
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            title: Text(
              todoList.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  totalItems == 0
                      ? 'No items in list'
                      : 'Completed: ${todoList.completedItems}, '
                          'Active: ${todoList.activeItems}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (totalItems != 0)
                  Text(
                    'Progress: $progress',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  )
              ],
            ),
            onTap: () => Navigator.push(
              context,
              TodoOverviewPage.route(todoList: todoList),
            ),
          ),
        ),
      ),
    );
  }
}
