class TorrentContentModel {
  int index;
  String path;
  String filename;
  var percentComplete;
  int priority;
  int sizeBytes;
  int depth;
  List<String> parentPath;

  TorrentContentModel({
    this.filename,
    this.index,
    this.path,
    this.percentComplete,
    this.priority,
    this.sizeBytes,
    this.depth,
    this.parentPath,
  });

  TorrentContentModel.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    path = json['path'];
    filename = json['filename'];
    percentComplete = json['percentComplete'];
    priority = json['priority'];
    sizeBytes = json['sizeBytes'];
    depth = path.split('/').length;
    parentPath = path.split('/');
  }
}
