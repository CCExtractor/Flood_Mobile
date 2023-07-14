import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flood_mobile/Model/current_user_detail_model.dart';

void main() {
  group('UserDetailBloc', () {
    late UserDetailBloc userDetailBloc;

    setUp(() {
      userDetailBloc = UserDetailBloc();
    });

    tearDown(() => userDetailBloc.close());

    test('initial state is correct', () {
      expect(userDetailBloc.state, equals(UserDetailInitial()));
    });

    group('SetUserDetailsEvent', () {
      final newToken = 'test token';
      final newUsername = 'testUsername';

      blocTest<UserDetailBloc, UserDetailState>(
        'emits UserDetailLoaded state when SetUserDetailsEvent is added',
        build: () => userDetailBloc,
        act: (bloc) => bloc
            .add(SetUserDetailsEvent(token: newToken, username: newUsername)),
        expect: () => [
          UserDetailInitial(),
          UserDetailLoaded(
              token: newToken, username: newUsername, usersList: []),
        ],
      );

      blocTest<UserDetailBloc, UserDetailState>(
        'updates token and username in UserDetailLoaded state',
        build: () => userDetailBloc,
        act: (bloc) => bloc
            .add(SetUserDetailsEvent(token: newToken, username: newUsername)),
        expect: () => [
          UserDetailInitial(),
          UserDetailLoaded(
              token: newToken, username: newUsername, usersList: []),
        ],
        verify: (bloc) {
          expect(bloc.token, equals(newToken));
          expect(bloc.username, equals(newUsername));
        },
      );
    });

    group('SetUsersListEvent', () {
      final usersList = [
        CurrentUserDetailModel(username: 'user1', level: 1),
        CurrentUserDetailModel(username: 'user2', level: 2),
      ];

      blocTest<UserDetailBloc, UserDetailState>(
        'emits UserDetailLoaded state when SetUsersListEvent is added',
        build: () => userDetailBloc,
        act: (bloc) => bloc.add(SetUsersListEvent(usersList: usersList)),
        expect: () => [
          UserDetailInitial(),
          UserDetailLoaded(token: '', username: '', usersList: usersList),
        ],
      );

      blocTest<UserDetailBloc, UserDetailState>(
        'updates usersList in UserDetailLoaded state',
        build: () => userDetailBloc,
        act: (bloc) => bloc.add(SetUsersListEvent(usersList: usersList)),
        expect: () => [
          UserDetailInitial(),
          UserDetailLoaded(token: '', username: '', usersList: usersList),
        ],
        verify: (bloc) {
          expect(bloc.usersList, equals(usersList));
        },
      );
    });
  });
}
