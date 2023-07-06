part of 'view.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignupPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up'), centerTitle: true),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _EmailInput(),
          SizedBox(height: 20),
          _PasswordInput(),
          SizedBox(height: 40),
          _LoginButton(),
          SizedBox(height: 20),
          _LoginLink(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        key: const Key('loginForm_emailInput_textField'),
        label: 'Email',
        errorText: null,
        onChanged: (email) => {});
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        key: const Key('loginForm_passwordInput_textField'),
        label: 'Password',
        errorText: null,
        onChanged: (password) => {});
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return const Button(
      key: Key('loginForm_button'),
      onPressed: null,
      label: 'Sign Up',
    );
  }
}

class _LoginLink extends StatelessWidget {
  const _LoginLink();

  @override
  Widget build(BuildContext context) {
    return LinkText(
      text: 'Already have an account? ',
      boldText: 'Log In',
      onTap: () => Navigator.pushReplacement(context, LoginPage.route()),
    );
  }
}
