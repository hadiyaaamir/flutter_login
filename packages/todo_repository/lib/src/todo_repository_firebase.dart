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
        .orderBy('dateCreated', descending: true)
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
  Future<int> clearCompleted({required String listId}) {
    final batch = FirebaseFirestore.instance.batch();
    return todoCollection
        .where('listId', isEqualTo: listId)
        .where('isCompleted', isEqualTo: true)
        .get()
        .then(
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
  Future<int> toggleCompleteAll(
      {required bool isCompleted, required String listId}) async {
    final batch = FirebaseFirestore.instance.batch();
    return todoCollection.where('listId', isEqualTo: listId).get().then(
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

  Future<void> todoListIncrementCompleted(
      {int value = 1, required String listId}) async {
    await todoListCollection.doc(listId).get().then((snapshot) {
      if (snapshot.data() != null) {
        saveTodoList(
          snapshot.data()!.copyWith(
              completedItems: snapshot.data()!.completedItems + value),
        );
      }
    });
  }

  Future<void> todoListDecrementCompleted(
      {int value = 1, required String listId}) async {
    await todoListCollection.doc(listId).get().then((snapshot) {
      if (snapshot.data() != null) {
        saveTodoList(
          snapshot.data()!.copyWith(
              completedItems: snapshot.data()!.completedItems - value),
        );
      }
    });
  }

  Future<void> todoListIncrementActive(
      {int value = 1, required String listId}) async {
    await todoListCollection.doc(listId).get().then((snapshot) {
      if (snapshot.data() != null) {
        saveTodoList(
          snapshot
              .data()!
              .copyWith(activeItems: snapshot.data()!.activeItems + value),
        );
      }
    });
  }

  Future<void> todoListDecrementActive(
      {int value = 1, required String listId}) async {
    await todoListCollection.doc(listId).get().then((snapshot) {
      if (snapshot.data() != null) {
        saveTodoList(
          snapshot
              .data()!
              .copyWith(activeItems: snapshot.data()!.activeItems - value),
        );
      }
    });
  }

  @override
  Future<void> todoListSetActive(
      {required int value, required String listId}) async {
    await todoListCollection.doc(listId).get().then((snapshot) {
      if (snapshot.data() != null) {
        saveTodoList(
          snapshot.data()!.copyWith(activeItems: value),
        );
      }
    });
  }

  @override
  Future<void> todoListSetCompleted(
      {required int value, required String listId}) async {
    await todoListCollection.doc(listId).get().then((snapshot) {
      if (snapshot.data() != null) {
        saveTodoList(
          snapshot.data()!.copyWith(completedItems: value),
        );
      }
    });
  }
}
