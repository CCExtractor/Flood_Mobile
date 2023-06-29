import 'package:flood_mobile/Pages/torrent_screen/services/date_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    "Test Date Converting Function",
    () {
      final date = dateConverter(timestamp: 1659201146);
      expect(date, '30 / 7 / 2022');
    },
  );
}
