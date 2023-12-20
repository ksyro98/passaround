import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:passaround/data_structures/change_request.dart';
import 'package:passaround/entities/pa_user_manager.dart';
import 'package:passaround/features/profile/bloc/profile_bloc.dart';
import 'package:passaround/features/profile/bloc/profile_data_access.dart';

import '../dummy_pa_user.dart';
import 'mock_profile_data_access.dart';

void main() {
  group("happy path", () {
    const ProfileDataAccess dataAccess = MockProfileDataAccess(shouldSucceed: true);
    setUp(() => PaUserManager.get().current = DummyPaUser.get());

    blocTest("loads same user",
        build: () => ProfileBloc(dataAccess),
        act: (bloc) => bloc.add(const ProfileSameUserDetected()),
        expect: () => [
              ProfileState(ProfileStateValue.ready, DummyPaUser.get(), ""),
            ]);

    blocTest(
      "edits user",
      build: () => ProfileBloc(dataAccess),
      seed: () => ProfileState(ProfileStateValue.ready, DummyPaUser.get(), ""),
      act: (bloc) => bloc.add(const ProfileEditRequested(ChangeRequest(key: "email", newValue: "dummyEmail2"))),
      expect: () => [
        ProfileState(ProfileStateValue.editing, DummyPaUser.get(), ""),
        ProfileState(ProfileStateValue.ready, DummyPaUser.getWithEmail("dummyEmail2"), ""),
      ],
      verify: (_) => expect(PaUserManager.get().current?.email, "dummyEmail2"),
    );

    blocTest(
      "logs out",
      build: () => ProfileBloc(dataAccess),
      seed: () => ProfileState(ProfileStateValue.ready, DummyPaUser.get(), ""),
      act: (bloc) => bloc.add(const ProfileLogOutRequested()),
      expect: () => [
        ProfileState(ProfileStateValue.loggedOut, DummyPaUser.get(), ""),
      ],
      verify: (_) => expect(PaUserManager.get().current, null),
    );
  });

  group("with errors", () {
    const ProfileDataAccess dataAccess = MockProfileDataAccess(shouldSucceed: false);
    setUp(() => PaUserManager.get().current = DummyPaUser.get());

    blocTest(
      "editing user fails",
      build: () => ProfileBloc(dataAccess),
      seed: () => ProfileState(ProfileStateValue.ready, DummyPaUser.get(), ""),
      act: (bloc) => bloc.add(const ProfileEditRequested(ChangeRequest(key: "email", newValue: "dummyEmail2"))),
      expect: () => [
        ProfileState(ProfileStateValue.editing, DummyPaUser.get(), ""),
        ProfileState(ProfileStateValue.error, DummyPaUser.get(), "Update error"),
        ProfileState(ProfileStateValue.ready, DummyPaUser.get(), ""),
      ],
      verify: (_) => expect(PaUserManager.get().current?.email, "dummyEmail"),
    );
  });
}
