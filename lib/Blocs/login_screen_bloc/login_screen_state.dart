part of 'login_screen_bloc.dart';

abstract class LoginScreenState extends Equatable {
  const LoginScreenState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginScreenState {}

class UpdatedLoginStatusState extends LoginScreenState {
  final bool loggedIn;

  UpdatedLoginStatusState({required this.loggedIn});

  @override
  List<Object> get props => [loggedIn];
}

class UpdatedBatteryOptimizationInfoState extends LoginScreenState {
  final bool seen;

  UpdatedBatteryOptimizationInfoState({required this.seen});

  @override
  List<Object> get props => [seen];
}
