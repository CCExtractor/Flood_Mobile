part of 'login_screen_bloc.dart';

abstract class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();

  @override
  List<Object> get props => [];
}

class SetLoggedInStatusEvent extends LoginScreenEvent {
  final bool loggedIn;

  SetLoggedInStatusEvent({required this.loggedIn});

  @override
  List<Object> get props => [loggedIn];
}

class SetBatteryOptimizationInfoStatusEvent extends LoginScreenEvent {
  final bool seen;

  SetBatteryOptimizationInfoStatusEvent({required this.seen});

  @override
  List<Object> get props => [seen];
}
