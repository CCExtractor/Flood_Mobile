import 'package:flood_mobile/Model/register_user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test RegisterUserModel', () {
    test('Test toJson() method for rTorrent socket client type', () {
      final registerUser = RegisterUserModel(
        username: 'john_doe',
        password: 'password123',
        client: 'rTorrent',
        type: 'socket',
        version: 1,
        url: '',
        clientUsername: '',
        clientPassword: '',
        level: 2,
        path: '/socket/path',
        host: '',
        port: 0,
      );

      final expectedJson = {
        'username': 'john_doe',
        'password': 'password123',
        'client': {
          'client': 'rTorrent',
          'type': 'socket',
          'version': 1,
          'socket': '/socket/path',
        },
        'level': 2,
      };

      expect(registerUser.toJson(), expectedJson);
    });

    test('Test toJson() method for rTorrent tcp client type', () {
      final registerUser = RegisterUserModel(
        username: 'john_doe',
        password: 'password123',
        client: 'rTorrent',
        type: 'tcp',
        version: 1,
        url: '',
        clientUsername: '',
        clientPassword: '',
        level: 2,
        path: '',
        host: 'localhost',
        port: 5000,
      );

      final expectedJson = {
        'username': 'john_doe',
        'password': 'password123',
        'client': {
          'client': 'rTorrent',
          'type': 'tcp',
          'version': 1,
          'host': 'localhost',
          'port': 5000,
        },
        'level': 2,
      };

      expect(registerUser.toJson(), expectedJson);
    });

    test('Test toJson() method for default client type', () {
      final registerUser = RegisterUserModel(
        username: 'john_doe',
        password: 'password123',
        client: 'SomeClient',
        type: 'SomeType',
        version: 1,
        url: 'https://example.com',
        clientUsername: 'client_user',
        clientPassword: 'client_password',
        level: 2,
        path: '',
        host: '',
        port: 0,
      );

      final expectedJson = {
        'username': 'john_doe',
        'password': 'password123',
        'client': {
          'client': 'SomeClient',
          'type': 'SomeType',
          'version': 1,
          'url': 'https://example.com',
          'username': 'client_user',
          'password': 'client_password',
        },
        'level': 2,
      };

      expect(registerUser.toJson(), expectedJson);
    });
  });
}
