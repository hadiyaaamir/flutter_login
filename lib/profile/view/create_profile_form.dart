part of 'view.dart';

class CreateProfileForm extends StatelessWidget {
  const CreateProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Failed to create profile')),
            );
        }
        if (state.status.isSuccess) {
          context.read<AuthenticationBloc>().add(AuthenticationUserChanged());
        }
      },
      child: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FirstNameInput(),
              SizedBox(height: 20),
              _LastNameInput(),
              SizedBox(height: 20),
              _DesignationInput(),
              SizedBox(height: 40),
              _CreateProfileButton(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  const _FirstNameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return CustomTextField(
          key: const Key('profileForm_firstNameInput_textField'),
          label: 'First Name',
          errorText: state.firstName.displayError != null
              ? 'field cannot be empty'
              : null,
          onChanged: (firstName) => context
              .read<ProfileBloc>()
              .add(ProfileFirstNameChanged(firstName)),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  const _LastNameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return CustomTextField(
          key: const Key('profileForm_lastNameInput_textField'),
          label: 'Last Name',
          errorText: state.lastName.displayError != null
              ? 'field cannot be empty'
              : null,
          onChanged: (lastName) =>
              context.read<ProfileBloc>().add(ProfileLastNameChanged(lastName)),
        );
      },
    );
  }
}

class _DesignationInput extends StatelessWidget {
  const _DesignationInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          previous.designation != current.designation,
      builder: (context, state) {
        return CustomTextField(
          key: const Key('profileForm_designationInput_textField'),
          label: 'Designation',
          errorText: state.designation.displayError != null
              ? 'field cannot be empty'
              : null,
          onChanged: (designation) => context
              .read<ProfileBloc>()
              .add(ProfileDesignationChanged(designation)),
        );
      },
    );
  }
}

class _CreateProfileButton extends StatelessWidget {
  const _CreateProfileButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : Button(
                key: const Key('profileForm_button'),
                onPressed: state.isValid
                    ? () => context
                        .read<ProfileBloc>()
                        .add(const ProfileSubmitted())
                    : null,
                label: 'Create Profile',
              );
      },
    );
  }
}
