class FileUtils {
  static const List<String> imageExtensions = [
    "jpg",
    "jpeg",
    "jpe",
    "jif",
    "jfif",
    "jfi",
    "png",
    "gif",
    "bmp",
    "dib",
    "tiff",
    "tif",
    "webp",
    "svg",
    "svgz",
    "ico",
    "raw",
    "arw",
    "cr2",
    "nef",
    "orf",
    "rw2",
    "raf",
  ];

  static bool isImage(String pathOrName) => imageExtensions.contains(getExtension(pathOrName));

  static String getNameWithExtension(String path) => path.split("/").last;

  static String getNameWithoutExtension(String path) {
    final String fileWithExtension = path.split("/").last;
    List<String> nameParts = fileWithExtension.split(".");
    nameParts.removeLast();
    return nameParts.join(".");
  }

  static String getExtension(String path) => path.split(".").last;

  // static String transformSizeUnit(int sizeInBytes) {
  //   double size = sizeInBytes.toDouble();
  //   List<String> units = ['B', 'KB', 'MB', 'GB', 'TB'];
  //   int multiplier = 1024;
  //
  //   int unitIndex = 0;
  //
  //   while (size >= multiplier && unitIndex < units.length - 1) {
  //     size /= multiplier;
  //     unitIndex++;
  //   }
  //
  //   String formattedSize = "${size.toStringAsFixed(2)} ${units[unitIndex]}";
  //
  //   return formattedSize;
  // }

  static String transformSizeUnit(num sizeInBytes, {int unitIndex = 0}) {
    List<String> units = ['B', 'KB', 'MB', 'GB', 'TB'];
    int multiplier = 1024;

    if(sizeInBytes < multiplier || unitIndex == units.length - 1) {
      return "${sizeInBytes.toStringAsFixed(2)} ${units[unitIndex]}";
    }
    return transformSizeUnit(sizeInBytes / multiplier, unitIndex: unitIndex + 1);

    // // int unitIndex = 0;
    //
    // while (size >= multiplier && unitIndex < units.length - 1) {
    //   size /= multiplier;
    //   unitIndex++;
    // }
    //
    // String formattedSize = "${size.toStringAsFixed(2)} ${units[unitIndex]}";
    //
    // return formattedSize;
  }
}
