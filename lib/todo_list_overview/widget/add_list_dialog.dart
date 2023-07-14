part of 'widget.dart';

class AddListDialog extends StatelessWidget {
  const AddListDialog({
    super.key,
    required this.todoListBloc,
  });

  final TodoListBloc todoListBloc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Todo List'),
      content: TextField(
        onChanged: (value) {
          todoListBloc.add(TodoListTitleChanged(title: value));
        },
        decoration: const InputDecoration(hintText: 'Enter title'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            todoListBloc.add(const TodoListAdded());
          },
          child: const Text('Add'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
