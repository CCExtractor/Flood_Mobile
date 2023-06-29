part of 'client_settings_bloc.dart';

abstract class ClientSettingsEvent extends Equatable {
  const ClientSettingsEvent();

  @override
  List<Object> get props => [];
}

class SetClientSettingsEvent extends ClientSettingsEvent {
  final ClientSettingsModel clientSettings;

  SetClientSettingsEvent({required this.clientSettings});

  @override
  List<Object> get props => [clientSettings];
}
