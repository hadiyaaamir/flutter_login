part of 'model.dart';

enum DesignationValidationError { empty }

class Designation extends FormzInput<String, DesignationValidationError> {
  const Designation.pure() : super.pure('');
  const Designation.dirty([super.value = '']) : super.dirty();

  @override
  DesignationValidationError? validator(String value) {
    return value.isEmpty ? DesignationValidationError.empty : null;
  }
}
