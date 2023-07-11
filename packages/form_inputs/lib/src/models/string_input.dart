part of 'models.dart';

enum StringInputValidationError { empty }

class StringInput extends FormzInput<String, StringInputValidationError> {
  const StringInput.pure() : super.pure('');
  const StringInput.dirty([super.value = '']) : super.dirty();

  @override
  StringInputValidationError? validator(String value) {
    return value.isEmpty ? StringInputValidationError.empty : null;
  }
}
