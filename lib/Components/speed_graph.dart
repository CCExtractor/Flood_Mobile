import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Model/graph_model.dart';
import 'package:flood_mobile/Provider/graph_provider.dart';
import 'package:flood_mobile/Provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SpeedGraph extends StatefulWidget {
  final HomeProvider model;
  final int index;
  const SpeedGraph({Key? key, required this.model, required this.index})
      : super(key: key);
  @override
  State<SpeedGraph> createState() => SpeedGraphState();
}

class SpeedGraphState extends State<SpeedGraph> {
  @override
  Widget build(BuildContext context) {
    var graph = Provider.of<GraphProvider>(context, listen: false);
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        graph.updateDataSource(widget.model);
        return SfCartesianChart(
          margin: EdgeInsets.all(0),
          borderWidth: 0,
          borderColor: Colors.transparent,
          plotAreaBorderWidth: 0,
          primaryXAxis: NumericAxis(
              isVisible: false,
              interval: 1,
              borderWidth: 0,
              borderColor: Colors.transparent),
          primaryYAxis: NumericAxis(
              interval: 1,
              isVisible: false,
              borderWidth: 0,
              borderColor: Colors.transparent),
          series: <ChartSeries<GraphModel, int>>[
            SplineAreaSeries(
              dataSource: graph.uploadGraphData,
              xValueMapper: (GraphModel data, index) => data.second,
              yValueMapper: (GraphModel data, index) => data.speed,
              splineType: SplineType.natural,
              gradient: LinearGradient(
                colors: themeProvider.isDarkMode
                    ? [
                        Color.fromARGB(255, 0, 111, 82),
                        Color(0xff191d2d).withAlpha(20)
                      ]
                    : [
                        ThemeProvider.theme(widget.index)
                            .primaryColorDark
                            .withAlpha(130),
                        Color.fromARGB(67, 255, 255, 255)
                      ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            SplineSeries(
              dataSource: graph.uploadGraphData,
              width: 1.8,
              xValueMapper: (GraphModel data, index) => data.second,
              yValueMapper: (GraphModel data, index) => data.speed,
              color: ThemeProvider.theme(widget.index).primaryColorDark,
            ),
            SplineAreaSeries(
              dataSource: graph.downloadGraphData,
              xValueMapper: (GraphModel data2, index) => data2.second,
              yValueMapper: (GraphModel data2, index) => data2.speed,
              splineType: SplineType.natural,
              gradient: LinearGradient(
                colors: themeProvider.isDarkMode
                    ? [
                        ThemeProvider.theme(widget.index)
                            .colorScheme
                            .secondary
                            .withAlpha(150),
                        Color(0xff191d2d).withAlpha(20)
                      ]
                    : [
                        ThemeProvider.theme(widget.index)
                            .colorScheme
                            .secondary
                            .withAlpha(120),
                        Color.fromARGB(37, 255, 255, 255)
                      ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            SplineSeries(
              dataSource: graph.downloadGraphData,
              xValueMapper: (GraphModel data2, index) => data2.second,
              yValueMapper: (GraphModel data2, index) => data2.speed,
              width: 1.8,
              color: ThemeProvider.theme(widget.index).colorScheme.secondary,
            ),
          ],
        );
      },
    );
  }
}
