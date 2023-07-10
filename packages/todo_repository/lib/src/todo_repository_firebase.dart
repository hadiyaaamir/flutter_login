part of 'todo_repository.dart';

class ToDoRepositoryFirebase extends TodoRepository {
  final todoCollection =
      FirebaseFirestore.instance.collection("ToDo").withConverter(
            fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
            toFirestore: (value, _) => value.toJson(),
          );

  @override
  Stream<List<Todo>> getTodos() {
    return todoCollection
        .orderBy('id')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) => e.data()).toList());
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    final todoFirestore = await todoCollection.doc(todo.id).get();

    todoFirestore.exists
        ? await todoCollection.doc(todo.id).set(todo)
        : await todoCollection.doc(todo.id).update(todo.toJson());
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todoFirestore = await todoCollection.where('id', isEqualTo: id).get();

    if (todoFirestore.docs.isEmpty) {
      throw TodoNotFoundException();
    } else {
      final todoFirestoreId = todoFirestore.docs[0].reference.id;
      await todoCollection.doc(todoFirestoreId).delete();
    }
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
  Future<int> completeAll({required bool isCompleted}) async {
    final batch = FirebaseFirestore.instance.batch();
    return todoCollection.get().then(
      (querySnapshot) {
        for (final document in querySnapshot.docs) {
          final completedTodo = document.data().copyWith(isCompleted: true);
          batch.update(document.reference, completedTodo.toJson());
        }
        batch.commit();
        return querySnapshot.docs.length;
      },
    );
  }
}
