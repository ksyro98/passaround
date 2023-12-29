import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:passaround/utils/native/native_api.dart';

import 'native_version.dart';

@immutable
class ChannelsApi implements PaNativeApi {
  static const versionPlatform = MethodChannel('io.thatcomeup.passaround/version');

  const ChannelsApi();

  @override
  Future<NativeVersion> getVersion() async {
    try {
      final result = await versionPlatform.invokeMethod<Map<Object?, Object?>>('getVersion');
      return NativeVersion(platform: result!["platform"]!.toString(), version: result["version"]!.toString());
    } on PlatformException catch(e) {
      throw PlatformException(code: e.code, message: "A platform exception was thrown: $e");
    } catch (e) {
      throw Exception("An exception was thrown: $e\nPlease note that this is NOT a PlatformException");
    }
  }

}
