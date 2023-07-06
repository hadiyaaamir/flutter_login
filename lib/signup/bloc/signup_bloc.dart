import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState()) {
    on<SignupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
