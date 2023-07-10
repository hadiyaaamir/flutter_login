part of 'view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, ProfilePage.route()),
            icon: const Icon(Icons.account_circle, size: 30),
          )
        ],
      ),
    );
  }
}
