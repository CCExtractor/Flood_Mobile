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
  List<String> tagListMain = [];
  Map<String, dynamic> mapTags = {'Untagged': 0};
  String trackerURISelected = '';
  List<String> trackerURIsList = [];
  List<String> trackerURIsListMain = [];
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

  void setTagsListMain(List<String> newTagListMain) {
    tagListMain = newTagListMain;
  }

  void setmapTags(Map<String, dynamic> newTagStatus) {
    mapTags.addAll(newTagStatus);
    // notifyListeners();
  }

  void setTagList(var newTagList) {
    tagList = newTagList;
  }

  void settrackerURISelected(String newtrackerURISelected) {
    trackerURISelected = newtrackerURISelected;
    notifyListeners();
  }

  void settrackerURIsList(List<String> newtrackerURIsList) {
    trackerURIsList = newtrackerURIsList;
  }

  void settrackerURIsListMain(List<String> newtrackerURIsListMain) {
    trackerURIsListMain = newtrackerURIsListMain;
  }

  void setmaptrackerURIs(var newmaptrackerURIs) {
    maptrackerURIs = newmaptrackerURIs;
  }
}
