part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthLogIn extends AuthEvent {
  final String email;
  final String password;

  const AuthLogIn(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class AuthSignUp extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const AuthSignUp(this.username, this.email, this.password);

  @override
  List<Object?> get props => [username, email, password];
}

class AuthRecoverPassword extends AuthEvent {
  final String email;

  const AuthRecoverPassword(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthSucceeded extends AuthEvent {
  final PaUser user;

  const AuthSucceeded(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthRecovered extends AuthEvent {
  const AuthRecovered();

  @override
  List<Object?> get props => [];
}

class AuthFailed extends AuthEvent {
  final String errorMessage;

  const AuthFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class AuthRecoverFromError extends AuthEvent {
  const AuthRecoverFromError();

  @override
  List<Object?> get props => [];
}

