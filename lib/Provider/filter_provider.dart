import 'package:flutter/cupertino.dart';

enum FilterValue {
  all,
  downloading,
  seeding,
  complete,
  stopped,
  active,
  inactive,
  error
}

class FilterProvider extends ChangeNotifier {
  FilterValue? filterStatus = FilterValue.all;
  List<String> statusList = [];
  var mapStatus = {};
  String tagSelected = '';
  List<String> tagList = [];
  Map<String, dynamic> mapTags = {'Untagged': 0};
  String trackerURISelected = '';
  List<String> trackerURIsList = [];
  var trackersSizeList = [];
  var tagsSizeList = [];
  var maptrackerURIs = {};

  void setFilterSelected(FilterValue? newfilterStatus) {
    filterStatus = newfilterStatus;
  }

  void setmapStatus(var newmapStatus) {
    mapStatus = newmapStatus;
  }

  void setstatusList(var newstatusList) {
    statusList = newstatusList;
  }

  void setTagSelected(String newtagSelected) {
    tagSelected = newtagSelected;
    notifyListeners();
  }

  void setmapTags(Map<String, dynamic> newTagStatus) {
    mapTags = newTagStatus;
  }

  void setTagsSizeList(var newTagsSizeList) {
    tagsSizeList = newTagsSizeList;
  }

  void settrackerURISelected(String newtrackerURISelected) {
    trackerURISelected = newtrackerURISelected;
    notifyListeners();
  }

  void setmaptrackerURIs(var newmaptrackerURIs) {
    maptrackerURIs = newmaptrackerURIs;
  }

  void setTrackersSizeList(var newTrackersSizeList) {
    trackersSizeList = newTrackersSizeList;
  }
}
