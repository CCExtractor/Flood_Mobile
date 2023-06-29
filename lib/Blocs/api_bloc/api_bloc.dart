import 'package:bloc/bloc.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc_event.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiState(baseUrl: 'http://localhost:3000')) {
    on<SetBaseUrlEvent>((event, emit) async {
      // Emit a new state with the updated URL
      emit(ApiState(baseUrl: event.url));
      // Store the updated URL in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('baseUrl', event.url);
    });
  }
}
