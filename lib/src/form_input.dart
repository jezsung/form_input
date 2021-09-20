import 'package:equatable/equatable.dart';

import 'form_input_status.dart';

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

  FormInputStatus get status {
    return _pure
        ? FormInputStatus.pure
        : _error != null || validate() != null
            ? FormInputStatus.invalid
            : FormInputStatus.valid;
  }

  bool get isPure => status == FormInputStatus.pure;
  bool get isValid => status == FormInputStatus.valid;
  bool get isInvalid => status == FormInputStatus.invalid;

  E? get error {
    if (_pure) {
      return null;
    } else if (_error != null) {
      return _error;
    } else {
      return validate();
    }
  }

  E? validate();

  @override
  List<Object?> get props => [value, _pure, _error];
}
