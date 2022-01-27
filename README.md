## Introduction

A simple form input representation helper class highly inspired by the `formz` package.

## Examples
``` dart
class EmailInput extends FormInput<String, Exception> {
  const EmailInput.pure([String value = '']) : super.pure(value);
  const EmailInput.dirty(String value) : super.dirty(value);
  // 'status' will be invalid, the validate function will be ignored.
  const EmailInput.invalid(String value, Exception e) : super.invalid(value, e);

  @override
  String sanitize(String value) {
    // 'rawValue' will be the value before the sanitize function called.
    // 'value' will be the value after the sanitize function called.
    return value.trim();
  }

  @override
  Exception? validate(String value) {
    if (value.isEmpty) {
      // Return Exception in case the validation fails.
      return FormatException('The email is empty.', value);
    }
    // Return null if the value is valid.
    return null;
  }
}
```