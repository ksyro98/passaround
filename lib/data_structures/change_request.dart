import 'package:equatable/equatable.dart';

class ChangeRequest<T> extends Equatable {
  final String key;
  final T newValue;

  const ChangeRequest({required this.key, required this.newValue});

  @override
  List<Object?> get props => [key, newValue];
}