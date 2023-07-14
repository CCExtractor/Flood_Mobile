import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Model/current_user_detail_model.dart';

void main() {
  group('Test CurrentUserDetailModel', () {
    final currentUserDetail = CurrentUserDetailModel(
      username: 'JohnDoe',
      level: 2,
    );

    final currentUserDetailJson = {
      'username': 'JohnDoe',
      'level': 2,
    };

    test('Test JSON to Model', () {
      final currentUserDetailFromJson =
          CurrentUserDetailModel.fromJson(currentUserDetailJson);
      expect(currentUserDetailFromJson.username, currentUserDetail.username);
      expect(currentUserDetailFromJson.level, currentUserDetail.level);
    });
  });
}
