import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passaround/data_structures/extended_bool.dart';

import '../../../data_structures/either.dart';
import '../../../entities/pa_user.dart';
import 'auth_data_access.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthDataAccess _dataAccess;

  AuthBloc(this._dataAccess) : super(const AuthState.initial()) {
    on<AuthLogIn>((event, emit) => _onLogIn(event, emit));
    on<AuthSignUp>((event, emit) => _onSignUp(event, emit));
    on<AuthRecoverPassword>((event, emit) => _onRecoverPassword(event, emit));
    on<AuthRecovered>((event, emit) => _onRecovered(event, emit));
    on<AuthSucceeded>((event, emit) => _onSucceeded(event, emit));
    on<AuthFailed>((event, emit) => _onFailed(event, emit));
    on<AuthRecoverFromError>((event, emit) => _onRecoverFromError(event, emit));
  }

  Future<void> _onLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    _setLoadingState(emit);

    await _manageAuthentication(
      email: event.email,
      password: event.password,
      authenticationMethod: _dataAccess.logIn,
    );
  }

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    _setLoadingState(emit);

    await _manageAuthentication(
      email: event.email,
      password: event.password,
      authenticationMethod: (managedEmail, managedPassword) => _dataAccess.signUp(
        username: event.username,
        email: managedEmail,
        password: managedPassword
      ),
    );
  }

  Future<void> _onRecoverPassword(AuthRecoverPassword event, Emitter<AuthState> emit) async {
    _setLoadingState(emit);

    final ExtendedBool res = await _dataAccess.recoverPassword(event.email);
    final succeeded = res.value;
    succeeded ? add(const AuthRecovered()) : add(AuthFailed(res.detail));
  }

  void _setLoadingState(Emitter<AuthState> emit) {
    AuthState newState = state.copyWith(value: AuthStateValue.loading);
    emit(newState);
  }

  Future<void> _manageAuthentication({
    required String email,
    required String password,
    required Future<Either<String, PaUser>> Function(String, String) authenticationMethod,
  }) async {
    final Either<String, PaUser> res = await authenticationMethod(email, password);

    final bool succeeded = res.hasSecond;
    final AuthEvent newEvent = succeeded ? AuthSucceeded(res.second!) : AuthFailed(res.first!);
    add(newEvent);
  }

  void _onSucceeded(AuthSucceeded event, Emitter<AuthState> emit) {
    PaUser.set(event.user);

    final AuthState newState = state.copyWith(value: AuthStateValue.loggedIn, error: "");
    emit(newState);
  }

  void _onRecovered(AuthRecovered event, Emitter<AuthState> emit) {
    final AuthState newState = state.copyWith(value: AuthStateValue.recoveryEmailSent, error: "");
    emit(newState);
  }

  void _onFailed(AuthFailed event, Emitter<AuthState> emit) {
    final AuthState newState = state.copyWith(value: AuthStateValue.error, error: event.errorMessage);
    emit(newState);

    add(const AuthRecoverFromError());
  }

  void _onRecoverFromError(AuthRecoverFromError event, Emitter<AuthState> emit) {
    final AuthState newState = state.copyWith(value: AuthStateValue.loggedOut, error: "");
    emit(newState);
  }
}
