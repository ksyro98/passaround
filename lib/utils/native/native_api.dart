import 'native_version.dart';

abstract class PaNativeApi {
  Future<NativeVersion> getVersion();

  void configureShareChannel(Map<String, void Function(Object)> methods);
}