part of 'client_settings_bloc.dart';

abstract class ClientSettingsState extends Equatable {
  const ClientSettingsState();

  @override
  List<Object> get props => [];
}

class ClientSettingsInitialState extends ClientSettingsState {}

class ClientSettingsUpdatedState extends ClientSettingsState {
  final ClientSettingsModel clientSettings;

  ClientSettingsUpdatedState({required this.clientSettings});

  @override
  List<Object> get props => [clientSettings];
}
