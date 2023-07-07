part of 'view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Profile'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider(
          create: (context) {
            return ProfileBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            );
          },
          child: const ProfileForm(),
        ),
      ),
    );
  }
}
