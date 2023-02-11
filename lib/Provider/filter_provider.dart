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
  String trackerURISelected = '';
  FilterValue? filterStatus = FilterValue.all;
  List<String> trackerURIsList = [];
  List<String> trackerURIsListMain = [];
  List<String> statusList = [];
  // size of the torrents
  List<String> sizeList = [];
  var maptrackerURIs = {};
  var mapStatus = {};
  void settrackerURISelected(String newtrackerURISelected) {
    trackerURISelected = newtrackerURISelected;
    notifyListeners();
  }

  void setFilterSelected(FilterValue? newfilterStatus) {
    filterStatus = newfilterStatus;
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

  void setmapStatus(var newmapStatus) {
    mapStatus = newmapStatus;
  }

  void setstatusList(var newstatusList) {
    statusList = newstatusList;
  }

  void setsizeList(var newsizeList) {
    sizeList = newsizeList;
  }
}
