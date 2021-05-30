class TorrentContentModel {
  int index;
  String path;
  String filename;
  int percentComplete;
  int priority;
  int sizeBytes;

  TorrentContentModel(
      {this.filename,
      this.index,
      this.path,
      this.percentComplete,
      this.priority,
      this.sizeBytes});

  TorrentContentModel.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    path = json['path'];
    filename = json['filename'];
    percentComplete = json['percentComplete'];
    priority = json['priority'];
    sizeBytes = json['sizeBytes'];
  }
}
