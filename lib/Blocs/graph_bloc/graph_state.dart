part of 'graph_bloc.dart';

class SpeedGraphState extends Equatable {
  final List<GraphModel> uploadGraphData;
  final List<GraphModel> downloadGraphData;
  final int fakeTime;
  final bool showChart;

  const SpeedGraphState({
    required this.uploadGraphData,
    required this.downloadGraphData,
    required this.fakeTime,
    required this.showChart,
  });

  @override
  List<Object> get props =>
      [uploadGraphData, downloadGraphData, fakeTime, showChart];

  SpeedGraphState copyWith({
    List<GraphModel>? uploadGraphData,
    List<GraphModel>? downloadGraphData,
    int? fakeTime,
    bool? showChart,
  }) {
    return SpeedGraphState(
      uploadGraphData: uploadGraphData ?? this.uploadGraphData,
      downloadGraphData: downloadGraphData ?? this.downloadGraphData,
      fakeTime: fakeTime ?? this.fakeTime,
      showChart: showChart ?? this.showChart,
    );
  }
}

class InitialSpeedGraphState extends SpeedGraphState {
  InitialSpeedGraphState()
      : super(
          uploadGraphData: List<GraphModel>.generate(30, ((index) {
            return GraphModel(speed: 0.00, second: index + 1);
          })),
          downloadGraphData: List<GraphModel>.generate(30, ((index) {
            return GraphModel(speed: 0.00, second: index + 1);
          })),
          fakeTime: 31,
          showChart: false,
        );
}
