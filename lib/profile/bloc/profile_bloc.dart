import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login/profile/model/model.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _userRepository = userRepository,
        _authenticationRepository = authenticationRepository,
        super(const ProfileState()) {
    on<ProfileFirstNameChanged>(_onFirstNameChanged);
    on<ProfileLastNameChanged>(_onLastNameChanged);
    on<ProfileDesignationChanged>(_onDesignationChanged);
    on<ProfileSubmitted>(_onSubmitted);
  }

  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;

  void _onFirstNameChanged(
    ProfileFirstNameChanged event,
    Emitter<ProfileState> emit,
  ) {
    final firstName = Name.dirty(event.firstName);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([firstName, state.lastName, state.designation]),
      ),
    );
  }

  void _onLastNameChanged(
    ProfileLastNameChanged event,
    Emitter<ProfileState> emit,
  ) {
    final lastName = Name.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: lastName,
        isValid: Formz.validate([state.firstName, lastName, state.designation]),
      ),
    );
  }

  void _onDesignationChanged(
    ProfileDesignationChanged event,
    Emitter<ProfileState> emit,
  ) {
    final designation = Designation.dirty(event.designation);
    emit(
      state.copyWith(
        designation: designation,
        isValid: Formz.validate([state.firstName, state.lastName, designation]),
      ),
    );
  }

  Future<void> _onSubmitted(
    ProfileSubmitted event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        await _userRepository
            .createUser(
                userId: _authenticationRepository.currentAuthUser!.uid,
                user: User(
                  firstName: state.firstName.value,
                  lastName: state.lastName.value,
                  email: _authenticationRepository.currentAuthUser!.email!,
                  designation: state.designation.value,
                ))
            .then((value) =>
                emit(state.copyWith(status: FormzSubmissionStatus.success)));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
