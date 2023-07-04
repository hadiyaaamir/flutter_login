part of 'view.dart';

class LoginAppView extends StatefulWidget {
  const LoginAppView({super.key});

  @override
  State<LoginAppView> createState() => _LoginAppViewState();
}

class _LoginAppViewState extends State<LoginAppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Placeholder(),
    );
  }
}
