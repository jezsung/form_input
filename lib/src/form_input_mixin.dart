import 'package:form_input/form_input.dart';

mixin FormInputMixin {
  bool get isAllPure => formInputs.every((input) => input.status == FormInputStatus.pure);
  bool get isAllValid => formInputs.every((input) => input.status == FormInputStatus.valid);

  List<FormInput> get formInputs;
}
