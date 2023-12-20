part of 'auth_bloc.dart';

enum AuthStateValue { loggedOut, loading, loggedIn, recoveryEmailSent, error }

class AuthState extends Equatable {
  final AuthStateValue value;
  final String error;

  const AuthState(this.value, this.error);

  const AuthState.initial()
      : value = AuthStateValue.loggedOut,
        error = "";

  AuthState copyWith({AuthStateValue? value, String? error}) => AuthState(
        value ?? this.value,
        error ?? this.error,
      );

  @override
  List<Object?> get props => [value, error];
}
