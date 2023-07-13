part of 'todo_repository.dart';

class ToDoRepositoryFirebase extends TodoRepository {
  final todoCollection =
      FirebaseFirestore.instance.collection("ToDo").withConverter(
            fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
            toFirestore: (value, _) => value.toJson(),
          );

  @override
  Stream<List<Todo>> getTodos(String userId) {
    return todoCollection
        .where('userId', isEqualTo: userId)
        .orderBy('isCompleted')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) => e.data()).toList());
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    await todoCollection.doc(todo.id).set(todo);
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
