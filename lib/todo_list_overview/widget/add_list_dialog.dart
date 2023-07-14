part of 'widget.dart';

class AddListDialog extends StatelessWidget {
  const AddListDialog({
    super.key,
    required this.todoListBloc,
    this.todoList,
  });

  final TodoListBloc todoListBloc;
  final TodoList? todoList;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${todoList == null ? 'Add' : 'Edit'} To Do List'),
      content: TextFormField(
        initialValue: todoList?.title,
        onChanged: (value) {
          todoListBloc.add(TodoListTitleChanged(title: value));
        },
        decoration: const InputDecoration(hintText: 'Enter title'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            todoListBloc.add(TodoListAdded(todoList: todoList));
          },
          child: Text(todoList == null ? 'Add' : 'Edit'),
        ),
      ],
    );
  }
}
