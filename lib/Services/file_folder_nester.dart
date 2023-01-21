import 'package:flood_mobile/Model/torrent_content_model.dart';

dynamic updateNestedMap(List keyPath, dynamic data, Function updater,
    [dynamic notSetValue, int i = 0]) {
  if (i == keyPath.length) {
    return updater(data == null ? notSetValue : data);
  }

  if (!(data is Map)) {
    data = {};
  }

  data = Map<String, dynamic>.from(data);

  data[keyPath[i]] =
      updateNestedMap(keyPath, data[keyPath[i]], updater, notSetValue, ++i);

  return data;
}

Map<String, dynamic> convertToFolder(
    List<TorrentContentModel> torrentContentList) {
  Map<String, dynamic> data = {};
  for (TorrentContentModel model in torrentContentList) {
    data = updateNestedMap(model.parentPath, data, (name) => model);
  }
  return data;
}
