import 'native_api.dart';

class NativeApiProvider {
  static PaNativeApi? _instance;

  static PaNativeApi get instance {
    if(_instance == null) {
      throw Exception("NativeApi instance is null. Did you forget to call `configure`?");
    }
    return _instance!;
  }

  static void configure(PaNativeApi api) {
    _instance = api;
  }
}