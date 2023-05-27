import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ApiProvider sut;

  setUp(() {
    sut = ApiProvider();
  });

  test(
    "initial values are correct",
    () {
      expect(sut.baseUrl, 'http://localhost:3000');
    },
  );

  group("setBaseUrl", () {
    final String newurl = "test url";
    test("check setBaseUrl working", () {
      expect(sut.baseUrl, 'http://localhost:3000');
      sut.setBaseUrl(newurl);
      expect(sut.baseUrl, newurl);
    });
  });
}
