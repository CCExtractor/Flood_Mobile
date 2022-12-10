import 'package:flood_mobile/Provider/user_detail_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserDetailProvider sut;

  setUp(() {
    sut = UserDetailProvider();
  });

  test(
    "initial values are correct",
    () {
      expect(sut.token, '');
    },
  );

  group('setToken', () {
    final newToken = 'test token';

    test(
      "tests setToken working",
      () async {
        expect(sut.token.isEmpty, true);
        sut.setToken(newToken);
        expect(sut.token.isEmpty, false);
        expect(sut.token, 'test token');
      },
    );
  });
}
