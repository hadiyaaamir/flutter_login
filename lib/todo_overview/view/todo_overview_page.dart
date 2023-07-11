part of 'view.dart';

class TodoOverviewPage extends StatelessWidget {
  const TodoOverviewPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const TodoOverviewPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'To Do List', profileButton: true),
    );
  }
}
