import 'package:flood_mobile/Model/graph_model.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter/cupertino.dart';

class GraphProvider extends ChangeNotifier {
  List<GraphModel> uploadGraphData = List<GraphModel>.generate(30, ((index) {
    return GraphModel(0.00, index + 1);
  }));
  List<GraphModel> downloadGraphData = List<GraphModel>.generate(30, ((index) {
    return GraphModel(0.00, index + 1);
  }));
  int fakeTime = 31;
  bool showChart = false;

  void changChartStatus() {
    showChart = !showChart;
    print(showChart);
    notifyListeners();
  }

  void updateDataSource(HomeProvider model) {
    double upspeed = model.upSpeed.contains('KB')
        ? double.parse(model.upSpeed.replaceAll(' KB/s', ''))
        : model.upSpeed.contains('MB')
            ? (double.parse(model.upSpeed.replaceAll(' MB/s', '')) * 1024)
            : (double.parse(model.upSpeed.replaceAll(' B/s', '')) / 1024);
    double downSpeed = model.downSpeed.contains('KB')
        ? double.parse(model.downSpeed.replaceAll(' KB/s', ''))
        : model.downSpeed.contains('MB')
            ? (double.parse(model.downSpeed.replaceAll(' MB/s', '')) * 1024)
            : (double.parse(model.upSpeed.replaceAll(' B/s', '')) / 1024);

    if ((uploadGraphData.last.speed == 0 &&
            downloadGraphData.last.speed == 0) ||
        (downloadGraphData.last.speed != 0 &&
            downloadGraphData.last.speed != downSpeed) ||
        (uploadGraphData.last.speed != 0 &&
            uploadGraphData.last.speed != upspeed)) {
      downloadGraphData.add(GraphModel(downSpeed, fakeTime));
      downloadGraphData.removeAt(0);
      uploadGraphData.add(GraphModel(upspeed, fakeTime));
      uploadGraphData.removeAt(0);
      fakeTime++;
      notifyListeners();
    }
  }
}
