import 'package:equatable/equatable.dart';

class ExtendedBool extends Equatable {
  final bool value;
  final String detail;

  const ExtendedBool(this.value, {this.detail = ""});

  @override
  List<Object?> get props => [value, detail];
}
