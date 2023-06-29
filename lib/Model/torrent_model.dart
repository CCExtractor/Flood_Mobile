import 'package:json_annotation/json_annotation.dart';
part 'torrent_model.g.dart';

@JsonSerializable()
class TorrentModel {
  double bytesDone;
  double dateAdded;
  double dateCreated;
  String directory;
  double downRate;
  double downTotal;
  double eta;
  String hash;
  bool isPrivate;
  bool isInitialSeeding;
  bool isSequential;
  String message;
  String name;
  double peersConnected;
  double peersTotal;
  double percentComplete;
  double priority;
  double ratio;
  double seedsConnected;
  double seedsTotal;
  double sizeBytes;
  List<String> status;
  List<String> tags;
  List<String> trackerURIs;
  double upRate;
  double upTotal;
  TorrentModel({
    required this.bytesDone,
    required this.dateAdded,
    required this.dateCreated,
    required this.directory,
    required this.downRate,
    required this.downTotal,
    required this.eta,
    required this.hash,
    required this.isInitialSeeding,
    required this.isPrivate,
    required this.isSequential,
    required this.message,
    required this.name,
    required this.peersConnected,
    required this.peersTotal,
    required this.percentComplete,
    required this.priority,
    required this.ratio,
    required this.seedsConnected,
    required this.seedsTotal,
    required this.sizeBytes,
    required this.status,
    required this.tags,
    required this.trackerURIs,
    required this.upRate,
    required this.upTotal,
  });
  factory TorrentModel.fromJson(Map<String, dynamic> data) =>
      _$TorrentModelFromJson(data);
  Map<String, dynamic> toJson() => _$TorrentModelToJson(this);
}
