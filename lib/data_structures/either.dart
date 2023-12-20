class Either<T,Y> {
  final T? _onFailure;
  final Y? _onSuccess;

  const Either(this._onFailure, this._onSuccess);

  const Either.firstOnly(this._onFailure) : _onSuccess = null;

  const Either.secondOnly(this._onSuccess) : _onFailure = null;

  T? get first => _onFailure;
  Y? get second => _onSuccess;

  bool get hasFirst => first != null;
  bool get hasSecond => second != null;

  T? getValueOnFailure() => first;
  T? getValueOnError() => first;
  Y? getValueOnSuccess() => second;
}
