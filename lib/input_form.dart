library input_form;

import 'package:equatable/equatable.dart';

abstract class InputForm<V, E> extends Equatable {
  const InputForm.pure(this.value)
      : _pure = true,
        _error = null;

  const InputForm.dirty(this.value)
      : _pure = false,
        _error = null;

  const InputForm.invalid(this.value, E error)
      : _pure = false,
        _error = error;

  final V value;
  final bool _pure;
  final E? _error;

  FormStatus get status {
    return _pure
        ? FormStatus.pure
        : _error != null || validate(value) != null
            ? FormStatus.invalid
            : FormStatus.valid;
  }

  E? get error => _pure ? null : _error ?? validate(value);

  E validate(V value);

  @override
  List<Object?> get props => [status, value, error];
}

mixin FormMixin {
  FormStatus get formStatus {
    return inputs.every((input) => input.status == FormStatus.pure)
        ? FormStatus.pure
        : inputs.any((input) => input.status == FormStatus.invalid)
            ? FormStatus.invalid
            : FormStatus.valid;
  }

  bool get isPure => formStatus == FormStatus.pure;
  bool get isInvalid => formStatus == FormStatus.invalid;
  bool get isValid => formStatus == FormStatus.valid;

  List<InputForm> get inputs;
}

enum FormStatus {
  pure,
  invalid,
  valid,
}

extension FormStatusX on FormStatus {
  bool get isPure => this == FormStatus.pure;
  bool get isInvalid => this == FormStatus.invalid;
  bool get isValid => this == FormStatus.valid;
}
