import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passaround/features/profile/bloc/profile_data_access.dart';

import '../../../data_structures/change_request.dart';
import '../../../entities/pa_user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileDataAccess _dataAccess;

  ProfileBloc(this._dataAccess) : super(const ProfileState.initial()) {
    on<ProfileSameUserDetected>(_onSameUserDetected);
    on<ProfileEditRequested>(_onEditRequested);
    on<ProfileEditSucceeded>(_onEditSucceeded);
    on<ProfileEditFailed>(_onEditFailed);
    on<ProfileRecoverFromError>(_onRecoverFromError);
    on<ProfileLogOutRequested>(_onLogOutRequested);
  }

  void _onSameUserDetected(ProfileSameUserDetected event, Emitter<ProfileState> emit) {
    ProfileState newState = state.copyWith(value: ProfileStateValue.ready, user: PaUser.instance);
    emit(newState);
  }

  Future<void> _onEditRequested(ProfileEditRequested event, Emitter<ProfileState> emit) async {
    ProfileState newState = state.copyWith(value: ProfileStateValue.editing);
    emit(newState);

    final PaUser newUser = state.user!.copyWithMap({event.changeRequest.key: event.changeRequest.newValue});

    final res = await _dataAccess.updateUser(event.changeRequest);
    final bool succeeded = res.hasSecond;

    return succeeded ? add(ProfileEditSucceeded(newUser)) : add(ProfileEditFailed(res.first ?? ""));
  }

  void _onEditSucceeded(ProfileEditSucceeded event, Emitter<ProfileState> emit) {
    PaUser.set(event.updatedUser);
    ProfileState newState = state.copyWith(value: ProfileStateValue.ready, user: event.updatedUser);
    emit(newState);
  }

  void _onEditFailed(ProfileEditFailed event, Emitter<ProfileState> emit) {
    ProfileState newState = state.copyWith(value: ProfileStateValue.error, errorMessage: event.errorMessage);
    emit(newState);

    add(const ProfileRecoverFromError());
  }

  void _onRecoverFromError(ProfileRecoverFromError event, Emitter<ProfileState> emit) {
    ProfileState newState = state.copyWith(value: ProfileStateValue.ready, errorMessage: "");
    emit(newState);
  }

  Future<void> _onLogOutRequested(ProfileLogOutRequested event, Emitter<ProfileState> emit) async {
    await _dataAccess.logOut();
    PaUser.unset();
    ProfileState newState = state.copyWith(value: ProfileStateValue.loggedOut);
    emit(newState);
  }
}
