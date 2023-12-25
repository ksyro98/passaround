import 'package:flutter/cupertino.dart';

@immutable
class AuthFormValidator {
  final GlobalKey<FormState>? _formKey;

  const AuthFormValidator(this._formKey);

  bool validate() {
    final bool ignoreForm = _formKey == null;
    final bool formIsValid = _formKey?.currentState?.validate() ?? false;
    return ignoreForm || formIsValid;
  }
}