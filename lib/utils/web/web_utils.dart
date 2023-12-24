import 'dart:html' show window;

import 'package:flutter/foundation.dart';
import 'package:passaround/utils/web/web_utils_interface.dart';

class WebUtils implements WebUtilsInterface {
  @override
  bool isFirefox() => kIsWeb && window.navigator.userAgent.contains("Firefox");
}
