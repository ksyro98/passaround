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

  static String getExtension(String path) => path.split(".").last;
}
