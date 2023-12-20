class Logger {
  static void lPrint(arg, { String separator = "---"}) {
    print(separator);
    print(arg.toString());
    print(separator);
  }

  static void ePrint(error) {
    print(error);
  }
}