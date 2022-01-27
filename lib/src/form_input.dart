import 'package:equatable/equatable.dart';

import 'form_input_status.dart';

abstract class FormInput<V, E> extends Equatable {
  const FormInput.pure(this._value)
      : _pure = true,
        _error = null;

  const FormInput.dirty(this._value)
      : _pure = false,
        _error = null;

  const FormInput.invalid(this._value, E error)
      : _pure = false,
        _error = error;

  final V _value;
  final E? _error;
  final bool _pure;

  V get value => sanitize(_value);

  E? get error {
    if (_pure) {
      return null;
    } else if (_error != null) {
      return _error;
    } else {
      return validate(value);
    }
  }

  V sanitize(V value) {
    return value;
  }

  E? validate(V value);

  FormInputStatus get status {
    return _pure
        ? FormInputStatus.pure
        : _error != null || validate(value) != null
            ? FormInputStatus.invalid
            : FormInputStatus.valid;
  }

  bool get pure => status == FormInputStatus.pure;
  bool get valid => status == FormInputStatus.valid;
  bool get invalid => status == FormInputStatus.invalid;

  @override
  List<Object?> get props => [_value, _pure, _error];
}
