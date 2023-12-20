part of 'profile_bloc.dart';

enum ProfileStateValue { initial, ready, editing, error, loggedOut }

class ProfileState extends Equatable {
  final ProfileStateValue value;
  final PaUser? user;
  final String errorMessage;

  const ProfileState(this.value, this.user, this.errorMessage);

  const ProfileState.initial()
      : value = ProfileStateValue.initial,
        user = null,
        errorMessage = "";

  ProfileState copyWith({ProfileStateValue? value, PaUser? user, String? errorMessage}) {
    return ProfileState(
      value ?? this.value,
      user ?? this.user,
      errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [value, user, errorMessage];
}
