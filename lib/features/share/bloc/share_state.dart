part of 'share_bloc.dart';

enum ShareStateValue { initial, loading, idle, sending, sendingFile, downloading, deleting, error }

class ShareState extends Equatable {
  final ShareStateValue value;
  final List<Item> data;
  final double sendingProgress;
  final String errorMessage;

  bool get isSending => value == ShareStateValue.sending || value == ShareStateValue.sendingFile;

  const ShareState(this.value, this.data, this.errorMessage, {this.sendingProgress = 0});

  const ShareState.initial()
      : value = ShareStateValue.initial,
        data = const [],
        errorMessage = "",
        sendingProgress = 0;

  ShareState copyWith({ShareStateValue? value, List<Item>? data, String? errorMessage, double? sendingProgress}) {
    return ShareState(
      value ?? this.value,
      data ?? this.data,
      errorMessage ?? this.errorMessage,
      sendingProgress: sendingProgress ?? this.sendingProgress,
    );
  }

  @override
  List<Object> get props => [value, data, errorMessage, sendingProgress];
}
