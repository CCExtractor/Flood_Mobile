import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Services/file_size_helper.dart';

void main() {
  test(
    "Test File Size Calculating Function",
    () {
      final size = filesize(1156498920);
      expect(size, '1.08 GB');
    },
  );
}
