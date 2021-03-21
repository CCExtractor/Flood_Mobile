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
  TorrentModel(
      this.bytesDone,
      this.dateAdded,
      this.dateCreated,
      this.directory,
      this.downRate,
      this.downTotal,
      this.eta,
      this.hash,
      this.isInitialSeeding,
      this.isPrivate,
      this.isSequential,
      this.message,
      this.name,
      this.peersConnected,
      this.peersTotal,
      this.percentComplete,
      this.priority,
      this.ratio,
      this.seedsConnected,
      this.seedsTotal,
      this.sizeBytes,
      this.status,
      this.tags,
      this.trackerURIs,
      this.upRate,
      this.upTotal);
  factory TorrentModel.fromJson(Map<String, dynamic> data) =>
      _$TorrentModelFromJson(data);
  Map<String, dynamic> toJson() => _$TorrentModelToJson(this);
}
