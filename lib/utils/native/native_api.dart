import 'native_version.dart';

abstract class PaNativeApi {
  Future<NativeVersion> getVersion();
}