part of 'todo_repository.dart';

class ToDoRepositoryFirebase extends TodoRepository {
  final todoCollection =
      FirebaseFirestore.instance.collection("ToDo").withConverter(
            fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
            toFirestore: (value, _) => value.toJson(),
          );

  final todoListCollection =
      FirebaseFirestore.instance.collection("ToDoList").withConverter(
            fromFirestore: (snapshot, _) => TodoList.fromJson(snapshot.data()!),
            toFirestore: (value, _) => value.toJson(),
          );

  Stream<List<TodoList>> getTodoLists({required String userId}) {
    return todoListCollection
        .where('userId', isEqualTo: userId)
        .orderBy('dateCreated')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) => e.data()).toList());
  }

  @override
  Stream<List<Todo>> getTodos({required String listId}) {
    return todoCollection
        .where('listId', isEqualTo: listId)
        .orderBy('isCompleted')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) => e.data()).toList());
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    await todoCollection.doc(todo.id).set(todo);
  }

  @override
  Future<void> saveTodoList(TodoList todoList) async {
    await todoListCollection.doc(todoList.id).set(todoList);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todoFirestore = await todoCollection.doc(id).get();

    todoFirestore.exists
        ? await todoCollection.doc(id).delete()
        : throw TodoNotFoundException();
  }

  @override
  Future<void> deleteTodoList(String id) async {
    final todoListFirestore = await todoListCollection.doc(id).get();

    todoListFirestore.exists
        ? await todoListCollection.doc(id).delete()
        : throw TodoListNotFoundException();
  }

  @override
  Future<int> clearCompleted() {
    final batch = FirebaseFirestore.instance.batch();
    return todoCollection.where('isCompleted', isEqualTo: true).get().then(
      (querySnapshot) {
        for (final document in querySnapshot.docs) {
          batch.delete(document.reference);
        }
        batch.commit();
        return querySnapshot.docs.length;
      },
    );
  }

  @override
  Future<int> toggleCompleteAll({required bool isCompleted}) async {
    final batch = FirebaseFirestore.instance.batch();
    return todoCollection.get().then(
      (querySnapshot) {
        for (final document in querySnapshot.docs) {
          final toggledTodo =
              document.data().copyWith(isCompleted: isCompleted);
          batch.update(document.reference, toggledTodo.toJson());
        }
        batch.commit();
        return querySnapshot.docs.length;
      },
    );
  }
}
