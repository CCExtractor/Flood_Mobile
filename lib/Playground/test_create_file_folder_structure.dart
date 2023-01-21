import 'dart:convert';
import 'package:flood_mobile/Model/torrent_content_model.dart';

dynamic updateNestedMap(List keyPath, dynamic data, Function updater,
    [dynamic notSetValue, int i = 0]) {
  if (i == keyPath.length) {
    return updater(data == null ? notSetValue : data);
  }

  if (!(data is Map)) {
    data = {};
  }

  data = Map<dynamic, dynamic>.from(data);

  data[keyPath[i]] =
      updateNestedMap(keyPath, data[keyPath[i]], updater, notSetValue, ++i);

  return data;
}

void main() {
  List<TorrentContentModel> torrentContentList = [];
  List<dynamic> testDataJson = json.decode(testData);
  for (dynamic data in testDataJson) {
    torrentContentList.add(TorrentContentModel.fromJson(data));
  }
  Map<dynamic, dynamic> data = {};
  for (TorrentContentModel model in torrentContentList) {
    data = updateNestedMap(model.parentPath, data, (name) => model);
  }
  print(data);
  for (TorrentContentModel model in torrentContentList) {
    if (model.parentPath.contains('0. Websites you may like')) {
      print(model.index);
    }
  }
}

String testData = '''
  [
    {
        "index": 1,
        "path": "a/0. Websites you may like/[FCS Forum].url",
        "filename": "[FCS Forum].url",
        "percentComplete": 0,
        "priority": 1,
        "sizeBytes": 133
    },
    {
        "index": 2,
        "path": "a/0. Websites you may like/[FreeCourseSite.com].url",
        "filename": "[FreeCourseSite.com].url",
        "percentComplete": 0,
        "priority": 1,
        "sizeBytes": 127
    },
    {
        "index": 3,
        "path": "a/1. Course introduction/1. Course structure.mp4",
        "filename": "1. Course structure.mp4",
        "percentComplete": 0,
        "priority": 1,
        "sizeBytes": 43504507
    },
    {
        "index": 4,
        "path": "a/1. Course introduction/1. Course structure.vtt",
        "filename": "1. Course structure.vtt",
        "percentComplete": 0,
        "priority": 1,
        "sizeBytes": 2212
    },
    {
        "index": 5,
        "path": "a/1. Course introduction/2. Technologies.mp4",
        "filename": "2. Technologies.mp4",
        "percentComplete": 0,
        "priority": 1,
        "sizeBytes": 46891040
    },
    {
        "index": 6,
        "path": "a/1. Course introduction/2. Technologies.vtt",
        "filename": "2. Technologies.vtt",
        "percentComplete": 0,
        "priority": 1,
        "sizeBytes": 5600
    },
    {
        "index": 7,
        "path": "a/1. Course introduction/3. Vagrant vs. Docker.mp4",
        "filename": "3. Vagrant vs. Docker.mp4",
        "percentComplete": 0,
        "priority": 1,
        "sizeBytes": 64560569
    },
    {
        "index": 8,
        "path": "a/1. Course introduction/3. Vagrant vs. Docker.vtt",
        "filename": "3. Vagrant vs. Docker.vtt",
        "percentComplete": 0,
        "priority": 1,
        "sizeBytes": 3244
    },
    {
        "index": 9,
        "path": "a/1. Course introduction/4. How to get the most out of this course.mp4",
        "filename": "4. How to get the most out of this course.mp4",
        "percentComplete": 0,
        "priority": 1,
        "sizeBytes": 23809354
    },
    {
        "index": 10,
        "path": "a/1. Course introduction/4. How to get the most out of this course.vtt",
        "filename": "4. How to get the most out of this course.vtt",
        "percentComplete": 0,
        "priority": 1,
        "sizeBytes": 1399
    },
    {
        "index": 11,
        "path": "a/1. Course introduction/5. How to get help.mp4",
        "filename": "5. How to get help.mp4",
        "percentComplete": 0,
        "priority": 1,
        "sizeBytes": 30664313
    },
    {
        "index": 12,
        "path": "a/1. Course introduction/5. How to get help.vtt",
        "filename": "5. How to get help.vtt",
        "percentComplete": 0,
        "priority": 1,
        "sizeBytes": 1785
    }
]  
  ''';
