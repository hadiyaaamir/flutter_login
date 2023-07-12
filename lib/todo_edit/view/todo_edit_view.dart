part of 'view.dart';

class TodoEditView extends StatelessWidget {
  const TodoEditView({super.key});

  @override
  Widget build(BuildContext context) {
    // final status = context.select((TodoEditBloc bloc) => bloc.state.status);
    final isNewTodo = context.select(
      (TodoEditBloc bloc) => bloc.state.isNewTodo,
    );
    final todo = context.select((TodoEditBloc bloc) => bloc.state.todo);

    return Scaffold(
      appBar: CustomAppBar(
        title: isNewTodo ? 'Add To-Do' : (todo?.title ?? 'Edit To Do'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            _TitleInput(),
            SizedBox(height: 20),
            _DescriptionInput(),
            // SizedBox(height: 40),
            // _EditTodoButton(),
          ]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const _EditTodoButton(),
    );
  }
}

class _TitleInput extends StatelessWidget {
  const _TitleInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEditBloc, TodoEditState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        return CustomTextField(
          key: const Key('editTodoForm_titleInput_textField'),
          label: 'Title',
          errorText:
              state.title.displayError != null ? 'field cannot be empty' : null,
          onChanged: (title) => context
              .read<TodoEditBloc>()
              .add(TodoEditTitleChanged(title: title)),
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  const _DescriptionInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoEditBloc, TodoEditState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return CustomTextField(
          key: const Key('editTodoForm_descriptionInput_textField'),
          label: 'Description',
          maxLines: 10,
          errorText: state.description.displayError != null
              ? 'field cannot be empty'
              : null,
          onChanged: (description) => context
              .read<TodoEditBloc>()
              .add(TodoEditDescriptionChanged(description: description)),
        );
      },
    );
  }
}

class _EditTodoButton extends StatelessWidget {
  const _EditTodoButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      child: BlocBuilder<TodoEditBloc, TodoEditState>(
        builder: (context, state) {
          return state.status.isLoadingOrSuccess
              ? const CircularProgressIndicator()
              : Button(
                  key: const Key('editTodoForm_button'),
                  onPressed: state.isValid
                      ? () => context
                          .read<TodoEditBloc>()
                          .add(const TodoEditSubmitted())
                      : null,
                  label: 'Edit To-Do',
                );
        },
      ),
    );
  }
}
