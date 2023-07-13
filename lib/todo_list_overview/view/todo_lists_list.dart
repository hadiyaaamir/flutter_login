part of 'view.dart';

class TodoListsList extends StatelessWidget {
  const TodoListsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoListBloc, TodoListState>(
      builder: (context, state) {
        if (state.todoLists.isEmpty) {
          return (state.status == TodoListStatus.loading)
              ? const Center(child: CircularProgressIndicator())
              : (state.status != TodoListStatus.success)
                  ? const SizedBox()
                  : const _EmptyList();
        }
        return const _NonEmptyList();
      },
    );
  }
}

class _NonEmptyList extends StatelessWidget {
  const _NonEmptyList();

  @override
  Widget build(BuildContext context) {
    List todoLists =
        context.select((TodoListBloc bloc) => bloc.state.todoLists);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.builder(
        itemCount: todoLists.length,
        itemBuilder: (context, index) =>
            ListListTile(todoList: todoLists[index]),
      ),
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    final todoListBloc = BlocProvider.of<TodoListBloc>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('You don\'t have any lists yet'),
          const SizedBox(height: 10),
          Button(
            label: 'Create List',
            width: 130,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AddListDialog(todoListBloc: todoListBloc),
            ),
          )
        ],
      ),
    );
  }
}
