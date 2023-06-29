import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flood_mobile/Blocs/client_settings_bloc/client_settings_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  late ClientSettingsBloc sut;
  late ClientSettingsModel newClientSettings;

  setUp(() {
    sut = ClientSettingsBloc();
    newClientSettings = ClientSettingsModel(
      dht: false,
      dhtPort: 1234,
      directoryDefault: 'path/to/directory',
      networkHttpMaxOpen: 10,
      networkLocalAddress: ['192.168.0.1', '192.168.0.2'],
      networkMaxOpenFiles: 100,
      networkPortOpen: true,
      networkPortRandom: false,
      networkPortRange: '6881-6889',
      piecesHashOnCompletion: true,
      piecesMemoryMax: 512,
      protocolPex: true,
      throttleGlobalDownSpeed: 1024,
      throttleGlobalUpSpeed: 2048,
      throttleMaxDownloads: 5,
      throttleMaxDownloadsGlobal: 10,
      throttleMaxPeersNormal: 50,
      throttleMaxPeersSeed: 100,
      throttleMaxUploads: 3,
      throttleMaxUploadsGlobal: 6,
      throttleMinPeersNormal: 10,
      throttleMinPeersSeed: 20,
      trackersNumWant: 30,
    );
  });

  tearDown(() => sut.close());

  blocTest<ClientSettingsBloc, ClientSettingsState>(
    'initial values are correct',
    build: () => sut,
    act: (bloc) =>
        bloc.add(SetClientSettingsEvent(clientSettings: newClientSettings)),
    expect: () =>
        [ClientSettingsUpdatedState(clientSettings: newClientSettings)],
  );
}
