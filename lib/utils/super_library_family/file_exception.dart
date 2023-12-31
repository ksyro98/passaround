class FileException implements Exception {
  final String message;

  const FileException([this.message = '']);
}