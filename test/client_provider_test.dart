import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flood_mobile/Provider/client_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ClientSettingsProvider sut;
  late ClientSettingsModel newClientSettings;

  setUp(() {
    sut = ClientSettingsProvider();
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

  test(
    "initial values are correct",
    () {
      sut.setClientSettings(newClientSettings);
      expect(sut.clientSettings, newClientSettings);
    },
  );
}
