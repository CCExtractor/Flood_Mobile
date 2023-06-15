part of 'user_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class SetUserDetailsEvent extends UserDetailEvent {
  final String token;
  final String username;

  SetUserDetailsEvent({required this.token, required this.username});

  @override
  List<Object> get props => [token, username];
}

class SetUsersListEvent extends UserDetailEvent {
  final List<CurrentUserDetailModel> usersList;

  SetUsersListEvent({required this.usersList});

  @override
  List<Object> get props => [usersList];
}
