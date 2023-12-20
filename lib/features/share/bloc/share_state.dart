part of 'share_bloc.dart';

enum ShareStateValue { initial, loading, idle, sending, downloading, deleting, error }

class ShareState extends Equatable {
  final ShareStateValue value;
  final List<Item> data;
  final String errorMessage;

  const ShareState(this.value, this.data, this.errorMessage);

  const ShareState.initial()
      : value = ShareStateValue.initial,
        data = const [],
        errorMessage = "";

  ShareState copyWith({ShareStateValue? value, List<Item>? data, String? errorMessage}) {
    return ShareState(value ?? this.value, data ?? this.data, errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [value, data, errorMessage];
}

