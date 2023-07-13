part of 'widget.dart';

class ListListTile extends StatelessWidget {
  const ListListTile({super.key, required this.todoList});

  final TodoList todoList;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          todoList.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          'Created on: ${todoList.dateCreated}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        onTap: () => Navigator.push(
          context,
          TodoOverviewPage.route(todoList: todoList),
        ),
      ),
    );
  }
}
