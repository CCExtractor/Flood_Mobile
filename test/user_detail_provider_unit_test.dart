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
      expect(sut.username, '');
    },
  );

  group('setToken', () {
    final newToken = 'test token';
    final newUsername = 'testUsername';

    test(
      "tests setUsersDetails working",
      () async {
        expect(sut.token.isEmpty, true);
        expect(sut.username.isEmpty, true);
        sut.setUserDetails(newToken, newUsername);
        expect(sut.token.isEmpty, false);
        expect(sut.username.isEmpty, false);
        expect(sut.token, 'test token');
        expect(sut.username, 'testUsername');
      },
    );
  });
}
