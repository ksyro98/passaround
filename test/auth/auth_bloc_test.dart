import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passaround/entities/pa_user_manager.dart';
import 'package:passaround/features/auth/bloc/auth_bloc.dart';
import 'package:passaround/features/auth/bloc/auth_data_access.dart';

import 'mock_auth_data_access.dart';

void main() {
  group("happy path :)", () {
    late AuthDataAccess dataAccess;
    setUp(() => dataAccess = MockAuthDataAccess(shouldSucceed: true));

    blocTest(
      "logs in",
      build: () => AuthBloc(dataAccess),
      act: (bloc) => bloc.add(const AuthLogIn("dummyEmail", "dummyPassword")),
      expect: () => [
        const AuthState(AuthStateValue.loading, ""),
        const AuthState(AuthStateValue.loggedIn, ""),
      ],
      verify: (_) => expect(PaUserManager.get().current?.email, "dummyEmail"),
    );

    blocTest(
      "signs up",
      build: () => AuthBloc(dataAccess),
      act: (bloc) => bloc.add(const AuthSignUp("dummyUsername", "dummyEmail", "dummyPassword")),
      expect: () => [
        const AuthState(AuthStateValue.loading, ""),
        const AuthState(AuthStateValue.loggedIn, ""),
      ],
      verify: (_) {
        expect(PaUserManager.get().current?.username, "dummyUsername");
        expect(PaUserManager.get().current?.email, "dummyEmail");
      },
    );

    blocTest(
      'recovers password',
      build: () => AuthBloc(dataAccess),
      act: (bloc) => bloc.add(const AuthRecoverPassword("dummyEmail")),
      expect: () => [
        const AuthState(AuthStateValue.loading, ""),
        const AuthState(AuthStateValue.recoveryEmailSent, ""),
      ],
    );
  });

  group("with errors", () {
    late AuthDataAccess dataAccess;
    setUp(() => dataAccess = MockAuthDataAccess(shouldSucceed: false));

    blocTest(
      "log in fails",
      build: () => AuthBloc(dataAccess),
      act: (bloc) => bloc.add(const AuthLogIn("dummyEmail", "dummyPassword")),
      expect: () => [
        const AuthState(AuthStateValue.loading, ""),
        const AuthState(AuthStateValue.error, "login error"),
        const AuthState(AuthStateValue.loggedOut, ""),
      ],
    );

    blocTest(
      "sign up fails",
      build: () => AuthBloc(dataAccess),
      act: (bloc) => bloc.add(const AuthSignUp("dummyUsername", "dummyEmail", "dummyPassword")),
      expect: () => [
        const AuthState(AuthStateValue.loading, ""),
        const AuthState(AuthStateValue.error, "signup error"),
        const AuthState(AuthStateValue.loggedOut, ""),
      ],
    );

    blocTest(
      'password recovery fails',
      build: () => AuthBloc(dataAccess),
      act: (bloc) => bloc.add(const AuthRecoverPassword("dummyEmail")),
      expect: () => [
        const AuthState(AuthStateValue.loading, ""),
        const AuthState(AuthStateValue.error, "recovery error"),
        const AuthState(AuthStateValue.loggedOut, ""),
      ],
    );
  });
}
