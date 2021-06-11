library form_input;

import 'package:equatable/equatable.dart';

enum FormStatus {
  pure,
  invalid,
  valid,
}

abstract class FormInput<V, E> extends Equatable {
  const FormInput.pure(this.value)
      : _pure = true,
        _error = null;

  const FormInput.dirty(this.value)
      : _pure = false,
        _error = null;

  const FormInput.invalid(this.value, E error)
      : _pure = false,
        _error = error;

  final V value;
  final bool _pure;
  final E? _error;

  FormStatus get status {
    return _pure
        ? FormStatus.pure
        : _error != null || validate() != null
            ? FormStatus.invalid
            : FormStatus.valid;
  }

  bool get isPure => status == FormStatus.pure;
  bool get isInvalid => status == FormStatus.invalid;
  bool get isValid => status == FormStatus.valid;

  E? get error => _pure ? null : _error ?? validate();

  E? validate();

  @override
  List<Object?> get props => [value, _pure, _error];
}

mixin FormMixin {
  bool get isPure => inputs.every((input) => input.status == FormStatus.pure);
  bool get isInvalid => inputs.any((input) => input.status == FormStatus.invalid);
  bool get isValid => inputs.every((input) => input.status == FormStatus.valid);

  List<FormInput> get inputs;
}
