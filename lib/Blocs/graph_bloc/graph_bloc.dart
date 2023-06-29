import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flood_mobile/Model/graph_model.dart';
import 'package:flood_mobile/Blocs/home_screen_bloc/home_screen_bloc.dart';

part 'graph_event.dart';
part 'graph_state.dart';

class SpeedGraphBloc extends Bloc<SpeedGraphEvent, SpeedGraphState> {
  SpeedGraphBloc() : super(InitialSpeedGraphState()) {
    on<ChangeChartStatusEvent>(_changeChartStatus);
    on<UpdateDataSourceEvent>(_updateDataSource);
  }

  // Handle the ChangeChartStatus event
  void _changeChartStatus(
      ChangeChartStatusEvent event, Emitter<SpeedGraphState> emit) {
    final currentState = state;
    emit(currentState.copyWith(showChart: !currentState.showChart));
  }

  // Handle the UpdateDataSource event
  void _updateDataSource(
      UpdateDataSourceEvent event, Emitter<SpeedGraphState> emit) {
    // Get the current state and create local copies of the graph data and model
    final currentState = state;
    final uploadGraphData = List<GraphModel>.from(currentState.uploadGraphData);
    final downloadGraphData =
        List<GraphModel>.from(currentState.downloadGraphData);
    final model = event.model.state;

    // Calculate upload speed based on the model data
    double upspeed = model.upSpeed.contains('KB')
        ? double.parse(model.upSpeed.replaceAll(' KB/s', ''))
        : model.upSpeed.contains('MB')
            ? (double.parse(model.upSpeed.replaceAll(' MB/s', '')) * 1024)
            : (double.parse(model.upSpeed.replaceAll(' B/s', '')) / 1024);

    // Calculate download speed based on the model data
    double downSpeed = model.downSpeed.contains('KB')
        ? double.parse(model.downSpeed.replaceAll(' KB/s', ''))
        : model.downSpeed.contains('MB')
            ? (double.parse(model.downSpeed.replaceAll(' MB/s', '')) * 1024)
            : (double.parse(model.downSpeed.replaceAll(' B/s', '')) / 1024);

    // Update the graph data if there is a change in speed
    if ((downloadGraphData.last.speed == 0 &&
            uploadGraphData.last.speed == 0) ||
        (downloadGraphData.last.speed != 0 &&
            downloadGraphData.last.speed != downSpeed) ||
        (uploadGraphData.last.speed != 0 &&
            uploadGraphData.last.speed != upspeed)) {
      // Add new graph data entry for download speed and remove the oldest entry
      downloadGraphData
          .add(GraphModel(speed: downSpeed, second: currentState.fakeTime));
      downloadGraphData.removeAt(0);

      // Add new graph data entry for upload speed and remove the oldest entry
      uploadGraphData
          .add(GraphModel(speed: upspeed, second: currentState.fakeTime));
      uploadGraphData.removeAt(0);

      // Create an updated state with the modified graph data and incremented fakeTime
      final updatedState = currentState.copyWith(
        uploadGraphData: uploadGraphData,
        downloadGraphData: downloadGraphData,
        fakeTime: currentState.fakeTime + 1,
      );

      // Emit the updated state
      emit(updatedState);
    }
  }
}
