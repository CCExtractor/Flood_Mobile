class TorrentContentModel {
  int index;
  String path;
  String filename;
  var percentComplete;
  int priority;
  int sizeBytes;
  int depth;
  List<String> parentPath;
  bool isMediaFile;

  TorrentContentModel({
    required this.filename,
    required this.index,
    required this.path,
    required this.percentComplete,
    required this.priority,
    required this.sizeBytes,
    required this.depth,
    required this.parentPath,
    required this.isMediaFile,
  });

  factory TorrentContentModel.fromJson(Map<String, dynamic> json) {
    return TorrentContentModel(
      index: json['index'],
      path: json['path'],
      filename: json['filename'],
      percentComplete: json['percentComplete'],
      priority: json['priority'],
      sizeBytes: json['sizeBytes'],
      depth: json['path'].split('/').length,
      parentPath: json['path'].split('/'),
      isMediaFile: (json['filename'].split('.').last == 'mp3' ||
          json['filename'].split('.').last == 'mp4'),
    );
  }
}
