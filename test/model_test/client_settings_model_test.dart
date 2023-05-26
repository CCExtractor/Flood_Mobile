import 'package:flood_mobile/Model/client_settings_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test ClientSettingsModel', () {
    final clientSettings = ClientSettingsModel(
      dht: true,
      dhtPort: 1234,
      directoryDefault: '/path/to/directory',
      networkHttpMaxOpen: 10,
      networkLocalAddress: ['192.168.1.100', '192.168.1.101'],
      networkMaxOpenFiles: 100,
      networkPortOpen: true,
      networkPortRandom: false,
      networkPortRange: '6881-6889',
      piecesHashOnCompletion: true,
      piecesMemoryMax: 512,
      protocolPex: true,
      throttleGlobalDownSpeed: 1024,
      throttleGlobalUpSpeed: 2048,
      throttleMaxPeersNormal: 50,
      throttleMaxPeersSeed: 100,
      throttleMaxDownloads: 5,
      throttleMaxDownloadsGlobal: 10,
      throttleMaxUploads: 5,
      throttleMaxUploadsGlobal: 10,
      throttleMinPeersNormal: 5,
      throttleMinPeersSeed: 10,
      trackersNumWant: 30,
    );

    final clientSettingsJson = {
      'dht': true,
      'dhtPort': 1234,
      'directoryDefault': '/path/to/directory',
      'networkHttpMaxOpen': 10,
      'networkLocalAddress': ['192.168.1.100', '192.168.1.101'],
      'networkMaxOpenFiles': 100,
      'networkPortOpen': true,
      'networkPortRandom': false,
      'networkPortRange': '6881-6889',
      'piecesHashOnCompletion': true,
      'piecesMemoryMax': 512,
      'protocolPex': true,
      'throttleGlobalDownSpeed': 1024,
      'throttleGlobalUpSpeed': 2048,
      'throttleMaxPeersNormal': 50,
      'throttleMaxPeersSeed': 100,
      'throttleMaxDownloads': 5,
      'throttleMaxDownloadsGlobal': 10,
      'throttleMaxUploads': 5,
      'throttleMaxUploadsGlobal': 10,
      'throttleMinPeersNormal': 5,
      'throttleMinPeersSeed': 10,
      'trackersNumWant': 30,
    };

    test('Test JSON to Model', () {
      final clientSettingsFromJson =
          ClientSettingsModel.fromJson(clientSettingsJson);
      expect(clientSettingsFromJson.dht, clientSettings.dht);
      expect(clientSettingsFromJson.dhtPort, clientSettings.dhtPort);
      expect(clientSettingsFromJson.directoryDefault,
          clientSettings.directoryDefault);
      expect(clientSettingsFromJson.networkHttpMaxOpen,
          clientSettings.networkHttpMaxOpen);
      expect(clientSettingsFromJson.networkLocalAddress,
          clientSettings.networkLocalAddress);
      expect(clientSettingsFromJson.networkMaxOpenFiles,
          clientSettings.networkMaxOpenFiles);
      expect(clientSettingsFromJson.networkPortOpen,
          clientSettings.networkPortOpen);
      expect(clientSettingsFromJson.networkPortRandom,
          clientSettings.networkPortRandom);
      expect(clientSettingsFromJson.networkPortRange,
          clientSettings.networkPortRange);
      expect(clientSettingsFromJson.piecesHashOnCompletion,
          clientSettings.piecesHashOnCompletion);
      expect(clientSettingsFromJson.piecesMemoryMax,
          clientSettings.piecesMemoryMax);
      expect(clientSettingsFromJson.protocolPex, clientSettings.protocolPex);
      expect(clientSettingsFromJson.throttleGlobalDownSpeed,
          clientSettings.throttleGlobalDownSpeed);
      expect(clientSettingsFromJson.throttleGlobalUpSpeed,
          clientSettings.throttleGlobalUpSpeed);
      expect(clientSettingsFromJson.throttleMaxPeersNormal,
          clientSettings.throttleMaxPeersNormal);
      expect(clientSettingsFromJson.throttleMaxPeersSeed,
          clientSettings.throttleMaxPeersSeed);
      expect(clientSettingsFromJson.throttleMaxDownloads,
          clientSettings.throttleMaxDownloads);
      expect(clientSettingsFromJson.throttleMaxDownloadsGlobal,
          clientSettings.throttleMaxDownloadsGlobal);
      expect(clientSettingsFromJson.throttleMaxUploads,
          clientSettings.throttleMaxUploads);
      expect(clientSettingsFromJson.throttleMaxUploadsGlobal,
          clientSettings.throttleMaxUploadsGlobal);
      expect(clientSettingsFromJson.throttleMinPeersNormal,
          clientSettings.throttleMinPeersNormal);
      expect(clientSettingsFromJson.throttleMinPeersSeed,
          clientSettings.throttleMinPeersSeed);
      expect(clientSettingsFromJson.trackersNumWant,
          clientSettings.trackersNumWant);
    });

    test('Test Model to JSON', () {
      final json = clientSettings.toJson();
      expect(json, clientSettingsJson);
    });
  });
}
