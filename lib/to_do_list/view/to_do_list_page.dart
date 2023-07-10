part of 'view.dart';

class ToDoListPage extends StatelessWidget {
  const ToDoListPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ToDoListPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'To Do List', profileButton: true),
    );
  }
}
