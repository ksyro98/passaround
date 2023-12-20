import 'package:flutter/foundation.dart';

class Logger {
  static void lPrint(arg, {String separator = "---"}) {
    if (kDebugMode) {
      print(separator);
      print(arg.toString());
      print(separator);
    }
  }

  static void ePrint(error) {
    if(kDebugMode) {
      print(error);
    }
  }
}
