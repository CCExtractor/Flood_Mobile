import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flood_mobile/Model/client_settings_model.dart';

part 'client_settings_event.dart';
part 'client_settings_state.dart';

class ClientSettingsBloc
    extends Bloc<ClientSettingsEvent, ClientSettingsState> {
  late ClientSettingsModel clientSettings;

  ClientSettingsBloc() : super(ClientSettingsInitialState()) {
    on<SetClientSettingsEvent>((event, emit) {
      // Update the clientSettings variable with the new client settings
      clientSettings = event.clientSettings;
      // Emit a ClientSettingsUpdatedState with the updated client settings
      emit(ClientSettingsUpdatedState(clientSettings: clientSettings));
    });
  }
}
