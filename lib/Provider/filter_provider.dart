import 'package:flutter/cupertino.dart';

enum FilterValue {
  all,
  downloading,
  seeding,
  complete,
  stopped,
  active,
  inactive
}

class FilterProvider extends ChangeNotifier {
  String trackerURISelected = '';
  FilterValue? filterStatus = FilterValue.all;
  List<String> trackerURIsList = [];
  void settrackerURISelected(String newtrackerURISelected) {
    trackerURISelected = newtrackerURISelected;
    notifyListeners();
  }

  void setFilterSelected(FilterValue? newfilterStatus) {
    filterStatus = newfilterStatus;
    notifyListeners();
  }

  void settrackerURIsList(List<String> newtrackerURIsList) {
    trackerURIsList = newtrackerURIsList;
    notifyListeners();
  }
}
