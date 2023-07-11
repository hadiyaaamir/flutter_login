part of 'view.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;
  late final TodoRepository _todoRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepositoryFirebase();
    _userRepository = UserRepositoryFirebase();
    _todoRepository = ToDoRepositoryFirebase();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _todoRepository),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),
        child: const LoginAppView(),
      ),
    );
  }
}
