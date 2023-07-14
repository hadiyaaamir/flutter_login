part of 'widget.dart';

class ListListTile extends StatelessWidget {
  const ListListTile(
      {super.key, required this.todoList, required this.onDismissed});

  final TodoList todoList;
  final DismissDirectionCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    final status = context.read<TodoListBloc>().state.status;

    final todoListBloc = BlocProvider.of<TodoListBloc>(context);

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
            title: _TitleRow(todoList: todoList, todoListBloc: todoListBloc),
            subtitle: _SubtitleRow(todoList: todoList),
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

class _TitleRow extends StatelessWidget {
  const _TitleRow({required this.todoList, required this.todoListBloc});

  final TodoList todoList;
  final TodoListBloc todoListBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          todoList.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        _EditButton(todoListBloc: todoListBloc, todoList: todoList),
      ],
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({required this.todoListBloc, required this.todoList});

  final TodoListBloc todoListBloc;
  final TodoList todoList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Icon(Icons.edit, size: 15),
      onTap: () => showDialog(
        context: context,
        builder: (context) => AddListDialog(
          todoListBloc: todoListBloc,
          todoList: todoList,
        ),
      ),
    );
  }
}

class _SubtitleRow extends StatelessWidget {
  const _SubtitleRow({
    required this.todoList,
  });

  final TodoList todoList;

  @override
  Widget build(BuildContext context) {
    final totalItems = todoList.activeItems + todoList.completedItems;
    final String progress = totalItems == 0
        ? ''
        : '${((todoList.completedItems.toDouble() / totalItems.toDouble()) * 100).toStringAsFixed(1)}%';

    return Row(
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
    );
  }
}
