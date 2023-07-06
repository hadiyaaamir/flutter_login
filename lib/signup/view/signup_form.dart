part of 'view.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: const Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _EmailInput(),
              SizedBox(height: 20),
              _PasswordInput(),
              SizedBox(height: 20),
              _ConfirmPasswordInput(),
              SizedBox(height: 40),
              _LoginButton(),
              SizedBox(height: 20),
              _LoginLink(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextField(
          key: const Key('loginForm_emailInput_textField'),
          label: 'Email',
          errorText: state.email.displayError != null ? 'invalid email' : null,
          onChanged: (email) =>
              context.read<SignupBloc>().add(SignupEmailChanged(email)),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return CustomTextField(
          obsecureText: true,
          key: const Key('loginForm_passwordInput_textField'),
          label: 'Password',
          errorText:
              state.password.displayError != null ? 'invalid password' : null,
          onChanged: (password) =>
              context.read<SignupBloc>().add(SignupPasswordChanged(password)),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return CustomTextField(
          obsecureText: true,
          key: const Key('loginForm_passwordInput_textField'),
          label: 'Confirm Password',
          errorText: state.password.displayError != null
              ? 'passwords do not match'
              : null,
          onChanged: (confirmPassword) => context
              .read<SignupBloc>()
              .add(SignupConfirmedPasswordChanged(confirmPassword)),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : Button(
                key: const Key('loginForm_button'),
                onPressed: state.isValid
                    ? () {
                        context.read<SignupBloc>().add(const SignupSubmitted());
                      }
                    : null,
                label: 'Sign Up',
              );
      },
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