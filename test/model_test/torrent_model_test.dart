import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Model/torrent_model.dart';

void main() {
  group('Test TorrentModel', () {
    final torrent = TorrentModel(
      bytesDone: 1024.0,
      dateAdded: 1621836000.0,
      dateCreated: 1621836000.0,
      directory: '/path/to/directory',
      downRate: 1024.0,
      downTotal: 2048.0,
      eta: 3600.0,
      hash: 'torrent_hash',
      isPrivate: true,
      isInitialSeeding: false,
      isSequential: true,
      message: 'Sample message',
      name: 'Sample torrent',
      peersConnected: 10.0,
      peersTotal: 100.0,
      percentComplete: 50.0,
      priority: 1.0,
      ratio: 2.0,
      seedsConnected: 5.0,
      seedsTotal: 10.0,
      sizeBytes: 1048576.0,
      status: ['Downloading', 'Seeding'],
      tags: ['tag1', 'tag2'],
      trackerURIs: ['http://tracker1.com', 'http://tracker2.com'],
      upRate: 512.0,
      upTotal: 1024.0,
    );

    final torrentJson = {
      'bytesDone': 1024.0,
      'dateAdded': 1621836000.0,
      'dateCreated': 1621836000.0,
      'directory': '/path/to/directory',
      'downRate': 1024.0,
      'downTotal': 2048.0,
      'eta': 3600.0,
      'hash': 'torrent_hash',
      'isPrivate': true,
      'isInitialSeeding': false,
      'isSequential': true,
      'message': 'Sample message',
      'name': 'Sample torrent',
      'peersConnected': 10.0,
      'peersTotal': 100.0,
      'percentComplete': 50.0,
      'priority': 1.0,
      'ratio': 2.0,
      'seedsConnected': 5.0,
      'seedsTotal': 10.0,
      'sizeBytes': 1048576.0,
      'status': ['Downloading', 'Seeding'],
      'tags': ['tag1', 'tag2'],
      'trackerURIs': ['http://tracker1.com', 'http://tracker2.com'],
      'upRate': 512.0,
      'upTotal': 1024.0,
    };

    test('Test JSON to Model', () {
      final torrentFromJson = TorrentModel.fromJson(torrentJson);
      expect(torrentFromJson.bytesDone, torrent.bytesDone);
      expect(torrentFromJson.dateAdded, torrent.dateAdded);
      expect(torrentFromJson.dateCreated, torrent.dateCreated);
      expect(torrentFromJson.directory, torrent.directory);
      expect(torrentFromJson.downRate, torrent.downRate);
      expect(torrentFromJson.downTotal, torrent.downTotal);
      expect(torrentFromJson.eta, torrent.eta);
      expect(torrentFromJson.hash, torrent.hash);
      expect(torrentFromJson.isPrivate, torrent.isPrivate);
      expect(torrentFromJson.isInitialSeeding, torrent.isInitialSeeding);
      expect(torrentFromJson.isSequential, torrent.isSequential);
      expect(torrentFromJson.message, torrent.message);
      expect(torrentFromJson.name, torrent.name);
      expect(torrentFromJson.peersConnected, torrent.peersConnected);
      expect(torrentFromJson.peersTotal, torrent.peersTotal);
      expect(torrentFromJson.percentComplete, torrent.percentComplete);
      expect(torrentFromJson.priority, torrent.priority);
      expect(torrentFromJson.ratio, torrent.ratio);
      expect(torrentFromJson.seedsConnected, torrent.seedsConnected);
      expect(torrentFromJson.seedsTotal, torrent.seedsTotal);
      expect(torrentFromJson.sizeBytes, torrent.sizeBytes);
      expect(torrentFromJson.status, torrent.status);
      expect(torrentFromJson.tags, torrent.tags);
      expect(torrentFromJson.trackerURIs, torrent.trackerURIs);
      expect(torrentFromJson.upRate, torrent.upRate);
      expect(torrentFromJson.upTotal, torrent.upTotal);
    });

    test('Test Model to JSON', () {
      final json = torrent.toJson();
      expect(json, torrentJson);
    });
  });
}
