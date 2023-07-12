part of 'widgets.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onToggleCompleted,
    required this.onDismissed,
  });

  final Todo todo;
  final Function() onTap;
  final DismissDirectionCallback onDismissed;
  final ValueChanged<bool> onToggleCompleted;

  @override
  Widget build(BuildContext context) {
    final status = context.read<TodoOverviewBloc>().state.status;

    return Dismissible(
      key: Key('todoListTile_dismissible_${todo.id}'),
      onDismissed: status == TodosOverviewStatus.loading ? null : onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.delete, color: Theme.of(context).colorScheme.onError),
      ),
      child: ListTile(
        title: Text(
          todo.title,
          style: !todo.isCompleted
              ? null
              : const TextStyle(
                  // color: captionColor,
                  decoration: TextDecoration.lineThrough,
                ),
        ),
        subtitle: todo.description.isNotEmpty ? Text(todo.description) : null,
        onTap: onTap,
        leading: Checkbox(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          value: todo.isCompleted,
          onChanged: (value) => onToggleCompleted(value!),
        ),
      ),
    );
  }
}
