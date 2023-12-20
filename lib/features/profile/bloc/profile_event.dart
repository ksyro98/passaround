part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {
  const ProfileEvent();
}

class ProfileSameUserDetected extends ProfileEvent {
  const ProfileSameUserDetected();
}

class ProfileEditRequested extends ProfileEvent {
  final ChangeRequest<String> changeRequest;

  const ProfileEditRequested(this.changeRequest);
}

class ProfileEditSucceeded extends ProfileEvent {
  final PaUser updatedUser;

  const ProfileEditSucceeded(this.updatedUser);
}

class ProfileEditFailed extends ProfileEvent {
  final String errorMessage;

  const ProfileEditFailed(this.errorMessage);
}

class ProfileRecoverFromError extends ProfileEvent {
  const ProfileRecoverFromError();
}

class ProfileLogOutRequested extends ProfileEvent {
  const ProfileLogOutRequested();
}

