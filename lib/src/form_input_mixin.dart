import 'package:form_input/form_input.dart';

mixin FormInputMixin {
  bool get pure => inputs.every((input) => input.status == FormInputStatus.pure);
  bool get valid => inputs.every((input) => input.status == FormInputStatus.valid);

  List<FormInput> get inputs;
}
