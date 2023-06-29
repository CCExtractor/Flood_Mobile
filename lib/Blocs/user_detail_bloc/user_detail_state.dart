part of 'user_detail_bloc.dart';

class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final String token;
  final String username;
  final List<CurrentUserDetailModel> usersList;

  UserDetailLoaded(
      {required this.token, required this.username, required this.usersList});

  @override
  List<Object> get props => [token, username, usersList];
}
