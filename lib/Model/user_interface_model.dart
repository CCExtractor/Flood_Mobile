import 'package:equatable/equatable.dart';

enum TagPreferenceButtonValue { singleSelection, multiSelection }

class UserInterfaceModel extends Equatable {
  final bool showProgressBar;
  final bool showDateAdded;
  final bool showDateCreated;
  final bool showRatio;
  final bool showLocation;
  final bool showTags;
  final bool showTrackers;
  final bool showTrackersMessage;
  final bool showDownloadSpeed;
  final bool showUploadSpeed;
  final bool showPeers;
  final bool showSeeds;
  final bool showSize;
  final bool showType;
  final bool showHash;
  final bool showDelete;
  final bool showSetTags;
  final bool showCheckHash;
  final bool showReannounce;
  final bool showSetTrackers;
  final bool showGenerateMagnetLink;
  final bool showPriority;
  final bool showInitialSeeding;
  final bool showSequentialDownload;
  final bool showDownloadTorrent;
  final TagPreferenceButtonValue tagPreferenceButtonValue;

  const UserInterfaceModel({
    required this.showProgressBar,
    required this.showDateAdded,
    required this.showDateCreated,
    required this.showRatio,
    required this.showLocation,
    required this.showTags,
    required this.showTrackers,
    required this.showTrackersMessage,
    required this.showDownloadSpeed,
    required this.showUploadSpeed,
    required this.showPeers,
    required this.showSeeds,
    required this.showSize,
    required this.showType,
    required this.showHash,
    required this.showDelete,
    required this.showSetTags,
    required this.showCheckHash,
    required this.showReannounce,
    required this.showSetTrackers,
    required this.showGenerateMagnetLink,
    required this.showPriority,
    required this.showInitialSeeding,
    required this.showSequentialDownload,
    required this.showDownloadTorrent,
    required this.tagPreferenceButtonValue,
  });

  factory UserInterfaceModel.fromJson(Map<String, dynamic> json) {
    return UserInterfaceModel(
      showProgressBar: json['showProgressBar'] as bool,
      showDateAdded: json['showDateAdded'] as bool,
      showDateCreated: json['showDateCreated'] as bool,
      showRatio: json['showRatio'] as bool,
      showLocation: json['showLocation'] as bool,
      showTags: json['showTags'] as bool,
      showTrackers: json['showTrackers'] as bool,
      showTrackersMessage: json['showTrackersMessage'] as bool,
      showDownloadSpeed: json['showDownloadSpeed'] as bool,
      showUploadSpeed: json['showUploadSpeed'] as bool,
      showPeers: json['showPeers'] as bool,
      showSeeds: json['showSeeds'] as bool,
      showSize: json['showSize'] as bool,
      showType: json['showType'] as bool,
      showHash: json['showHash'] as bool,
      showDelete: json['showDelete'] as bool,
      showCheckHash: json['showCheckHash'] as bool,
      showReannounce: json['showReannounce'] as bool,
      showSetTags: json['showSetTags'] as bool,
      showSetTrackers: json['showSetTrackers'] as bool,
      showGenerateMagnetLink: json['showGenerateMagnetLink'] as bool,
      showPriority: json['showPriority'] as bool,
      showInitialSeeding: json['showInitialSeeding'] as bool,
      showSequentialDownload: json['showSequentialDownload'] as bool,
      showDownloadTorrent: json['showDownloadTorrent'] as bool,
      tagPreferenceButtonValue:
          json['tagPreferenceButtonValue'] == 'singleSelection'
              ? TagPreferenceButtonValue.singleSelection
              : TagPreferenceButtonValue.multiSelection,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'showProgressBar': showProgressBar,
      'showDateAdded': showDateAdded,
      'showDateCreated': showDateCreated,
      'showRatio': showRatio,
      'showLocation': showLocation,
      'showTags': showTags,
      'showTrackers': showTrackers,
      'showTrackersMessage': showTrackersMessage,
      'showDownloadSpeed': showDownloadSpeed,
      'showUploadSpeed': showUploadSpeed,
      'showPeers': showPeers,
      'showSeeds': showSeeds,
      'showSize': showSize,
      'showType': showType,
      'showHash': showHash,
      'showDelete': showDelete,
      'showCheckHash': showCheckHash,
      'showReannounce': showReannounce,
      'showSetTags': showSetTags,
      'showSetTrackers': showSetTrackers,
      'showGenerateMagnetLink': showGenerateMagnetLink,
      'showPriority': showPriority,
      'showInitialSeeding': showInitialSeeding,
      'showSequentialDownload': showSequentialDownload,
      'showDownloadTorrent': showDownloadTorrent,
      'tagPreferenceButtonValue':
          tagPreferenceButtonValue == TagPreferenceButtonValue.singleSelection
              ? 'singleSelection'
              : 'multiSelection',
    };
  }

  @override
  List<Object?> get props => [
        showProgressBar,
        showDateAdded,
        showDateCreated,
        showRatio,
        showLocation,
        showTags,
        showTrackers,
        showTrackersMessage,
        showDownloadSpeed,
        showUploadSpeed,
        showPeers,
        showSeeds,
        showSize,
        showType,
        showHash,
        showDelete,
        showSetTags,
        showCheckHash,
        showReannounce,
        showSetTrackers,
        showGenerateMagnetLink,
        showPriority,
        showInitialSeeding,
        showSequentialDownload,
        showDownloadTorrent,
        tagPreferenceButtonValue,
      ];
}
