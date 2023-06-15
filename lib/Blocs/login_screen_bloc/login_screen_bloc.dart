import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginInitialState()) {
    on<SetLoggedInStatusEvent>(_onSetLoggedInStatusEvent);
    on<SetBatteryOptimizationInfoStatusEvent>(
        _onSetBatteryOptimizationInfoStatusEvent);
  }

  // Handle the SetLoggedInStatusEvent event
  void _onSetLoggedInStatusEvent(
      SetLoggedInStatusEvent event, Emitter<LoginScreenState> emit) async {
    // Save logged-in status in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedInData', event.loggedIn);
    emit(UpdatedLoginStatusState(loggedIn: event.loggedIn));
  }

  // Handle the SetBatteryOptimizationInfoStatusEvent event
  void _onSetBatteryOptimizationInfoStatusEvent(
    SetBatteryOptimizationInfoStatusEvent event,
    Emitter<LoginScreenState> emit,
  ) async {
    // Save battery optimization info status in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('batteryOptimizationInfoSeen', event.seen);
    emit(UpdatedBatteryOptimizationInfoState(seen: event.seen));
  }
}
