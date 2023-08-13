import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flood_mobile/Blocs/graph_bloc/graph_bloc.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Model/graph_model.dart';

class SpeedGraph extends StatefulWidget {
  final HomeScreenBloc model;
  final int themeIndex;
  const SpeedGraph({Key? key, required this.model, required this.themeIndex})
      : super(key: key);

  @override
  State<SpeedGraph> createState() => SpeedSpeedGraphState();
}

class SpeedSpeedGraphState extends State<SpeedGraph> {
  late Timer _timer;
  late SpeedGraphBloc _speedGraphBloc;

  @override
  void initState() {
    super.initState();
    _speedGraphBloc = BlocProvider.of<SpeedGraphBloc>(context, listen: false);

    // Start the timer when the widget is initialized
    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      _speedGraphBloc.add(UpdateDataSourceEvent(model: widget.model));
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      key: Key('Speed Graph'),
      margin: EdgeInsets.all(0),
      borderWidth: 0,
      borderColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        isVisible: false,
        interval: 1,
        borderWidth: 0,
        borderColor: Colors.transparent,
      ),
      primaryYAxis: NumericAxis(
        interval: 1,
        isVisible: false,
        borderWidth: 0,
        borderColor: Colors.transparent,
      ),
      series: <ChartSeries<GraphModel, int>>[
        SplineAreaSeries(
          dataSource: _speedGraphBloc.state.uploadGraphData,
          xValueMapper: (GraphModel data, index) => data.second,
          yValueMapper: (GraphModel data, index) => data.speed,
          splineType: SplineType.natural,
          gradient: LinearGradient(
            colors: BlocProvider.of<ThemeBloc>(context).isDarkMode
                ? [
                    Color.fromARGB(255, 0, 111, 82),
                    Color(0xff191d2d).withAlpha(20)
                  ]
                : [
                    ThemeBloc.theme(widget.themeIndex)
                        .primaryColorDark
                        .withAlpha(130),
                    Color.fromARGB(67, 255, 255, 255)
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        SplineSeries(
          dataSource: _speedGraphBloc.state.uploadGraphData,
          width: 1.8,
          xValueMapper: (GraphModel data, index) => data.second,
          yValueMapper: (GraphModel data, index) => data.speed,
          color: ThemeBloc.theme(widget.themeIndex).primaryColorDark,
        ),
        SplineAreaSeries(
          dataSource: _speedGraphBloc.state.downloadGraphData,
          xValueMapper: (GraphModel data2, index) => data2.second,
          yValueMapper: (GraphModel data2, index) => data2.speed,
          splineType: SplineType.natural,
          gradient: LinearGradient(
            colors: BlocProvider.of<ThemeBloc>(context).isDarkMode
                ? [
                    ThemeBloc.theme(widget.themeIndex)
                        .colorScheme
                        .secondary
                        .withAlpha(150),
                    Color(0xff191d2d).withAlpha(20)
                  ]
                : [
                    ThemeBloc.theme(widget.themeIndex)
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
          dataSource: _speedGraphBloc.state.downloadGraphData,
          xValueMapper: (GraphModel data2, index) => data2.second,
          yValueMapper: (GraphModel data2, index) => data2.speed,
          width: 1.8,
          color: ThemeBloc.theme(widget.themeIndex).colorScheme.secondary,
        ),
      ],
    );
  }
}
