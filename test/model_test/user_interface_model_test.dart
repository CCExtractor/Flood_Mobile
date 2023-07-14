import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Model/user_interface_model.dart';

void main() {
  group('UserInterfaceModel', () {
    test('fromJson should return a valid UserInterfaceModel object', () {
      final json = {
        'showDateAdded': true,
        'showDateCreated': false,
        'showRatio': true,
        'showLocation': false,
        'showTags': true,
        'showTrackers': false,
        'showTrackersMessage': true,
        'showDownloadSpeed': false,
        'showUploadSpeed': true,
        'showPeers': false,
        'showSeeds': true,
        'showSize': false,
        'showType': true,
        'showHash': false,
        'showDelete': true,
        'showSetTags': false,
        'showCheckHash': true,
        'showReannounce': false,
        'showSetTrackers': true,
        'showGenerateMagnetLink': false,
        'showPriority': true,
        'showInitialSeeding': false,
        'showSequentialDownload': true,
        'showDownloadTorrent': false,
      };

      final model = UserInterfaceModel.fromJson(json);

      expect(model.showDateAdded, true);
      expect(model.showDateCreated, false);
      expect(model.showRatio, true);
      expect(model.showLocation, false);
      expect(model.showTags, true);
      expect(model.showTrackers, false);
      expect(model.showTrackersMessage, true);
      expect(model.showDownloadSpeed, false);
      expect(model.showUploadSpeed, true);
      expect(model.showPeers, false);
      expect(model.showSeeds, true);
      expect(model.showSize, false);
      expect(model.showType, true);
      expect(model.showHash, false);
      expect(model.showDelete, true);
      expect(model.showSetTags, false);
      expect(model.showCheckHash, true);
      expect(model.showReannounce, false);
      expect(model.showSetTrackers, true);
      expect(model.showGenerateMagnetLink, false);
      expect(model.showPriority, true);
      expect(model.showInitialSeeding, false);
      expect(model.showSequentialDownload, true);
      expect(model.showDownloadTorrent, false);
      expect(model.showProgressBar, true);
      expect(model.tagPreferenceButtonValue,
          TagPreferenceButtonValue.multiSelection);
    });

    test('toJson should return a valid JSON map', () {
      final model = UserInterfaceModel(
          showDateAdded: true,
          showDateCreated: false,
          showRatio: true,
          showLocation: false,
          showTags: true,
          showTrackers: false,
          showTrackersMessage: true,
          showDownloadSpeed: false,
          showUploadSpeed: true,
          showPeers: false,
          showSeeds: true,
          showSize: false,
          showType: true,
          showHash: false,
          showDelete: true,
          showSetTags: false,
          showCheckHash: true,
          showReannounce: false,
          showSetTrackers: true,
          showGenerateMagnetLink: false,
          showPriority: true,
          showInitialSeeding: false,
          showSequentialDownload: true,
          showDownloadTorrent: false,
          showProgressBar: true,
          tagPreferenceButtonValue: TagPreferenceButtonValue.multiSelection);

      final json = model.toJson();

      expect(json['showDateAdded'], true);
      expect(json['showDateCreated'], false);
      expect(json['showRatio'], true);
      expect(json['showLocation'], false);
      expect(json['showTags'], true);
      expect(json['showTrackers'], false);
      expect(json['showTrackersMessage'], true);
      expect(json['showDownloadSpeed'], false);
      expect(json['showUploadSpeed'], true);
      expect(json['showPeers'], false);
      expect(json['showSeeds'], true);
      expect(json['showSize'], false);
      expect(json['showType'], true);
      expect(json['showHash'], false);
      expect(json['showDelete'], true);
      expect(json['showSetTags'], false);
      expect(json['showCheckHash'], true);
      expect(json['showReannounce'], false);
      expect(json['showSetTrackers'], true);
      expect(json['showGenerateMagnetLink'], false);
      expect(json['showPriority'], true);
      expect(json['showInitialSeeding'], false);
      expect(json['showSequentialDownload'], true);
      expect(json['showDownloadTorrent'], false);
      expect(json['showProgressBar'], true);
    });
  });
}
