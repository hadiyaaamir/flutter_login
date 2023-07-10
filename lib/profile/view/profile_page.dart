part of 'view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              builder: (context) {
                final firstName = context.select(
                  (AuthenticationBloc bloc) => bloc.state.user.firstName,
                );
                final lastName = context.select(
                  (AuthenticationBloc bloc) => bloc.state.user.lastName,
                );
                final email = context.select(
                  (AuthenticationBloc bloc) => bloc.state.user.email,
                );
                final designation = context.select(
                  (AuthenticationBloc bloc) => bloc.state.user.designation,
                );
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    children: [
                      ProfileInformation(
                        title: 'Name',
                        information: '$firstName $lastName',
                      ),
                      ProfileInformation(title: 'Email', information: email),
                      ProfileInformation(
                        title: 'Designation',
                        information: designation,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            Button(
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
                label: 'Log Out'),
          ],
        ),
      ),
    );
  }
}

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({
    super.key,
    required this.title,
    required this.information,
  });

  final String title;
  final String information;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Wrap(
          children: [
            Text(
              '$title: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(information)
          ],
        ),
      ),
    );
  }
}
