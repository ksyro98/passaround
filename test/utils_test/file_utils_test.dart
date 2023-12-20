import 'package:flutter_test/flutter_test.dart';
import 'package:passaround/utils/file_utils.dart';

void main() {
  group("transforms file size to different unit", () {
    test("0 bytes", () => _testFileSize(0, "0.00 B"));
    test("100 bytes", () => _testFileSize(100, "100.00 B"));
    test("500 bytes", () => _testFileSize(500, "500.00 B"));
    test("1000 bytes", () => _testFileSize(1000, "1000.00 B"));
    test("1024 bytes", () => _testFileSize(1024, "1.00 KB"));
    test("2048 bytes", () => _testFileSize(2048, "2.00 KB"));
    test("15000 bytes", () => _testFileSize(15000, "14.65 KB"));
    test("37213 bytes", () => _testFileSize(37213, "36.34 KB"));
    test("1048576 bytes", () => _testFileSize(1048576, "1.00 MB"));
    test("5242880 bytes", () => _testFileSize(5242880, "5.00 MB"));
    test("15728640 bytes", () => _testFileSize(15728640, "15.00 MB"));
    test("1073741824 bytes", () => _testFileSize(1073741824, "1.00 GB"));
    test("3221225472 bytes", () => _testFileSize(3221225472, "3.00 GB"));
    test("1099511627776 bytes", () => _testFileSize(1099511627776, "1.00 TB"));
    test("1125899906842624 bytes", () => _testFileSize(1125899906842624, "1024.00 TB"));
    test("123456789012345678 bytes", () => _testFileSize(123456789012345678, "112283.30 TB"));
    test("123 bytes", () => _testFileSize(123, "123.00 B"));
    test("500000000 bytes", () => _testFileSize(500000000, "476.84 MB"));
    test("999999999999999 bytes", () => _testFileSize(999999999999999, "909.49 TB"));
  });
}

void _testFileSize(int inputSizeInBytes, String expectedOutput) {
  int sizeInBytes = inputSizeInBytes;

  String res = FileUtils.transformSizeUnit(sizeInBytes);

  expect(res, expectedOutput);
}
