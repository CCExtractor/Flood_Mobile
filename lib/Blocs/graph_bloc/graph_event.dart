part of 'graph_bloc.dart';

abstract class SpeedGraphEvent extends Equatable {
  const SpeedGraphEvent();

  @override
  List<Object> get props => [];
}

class ChangeChartStatusEvent extends SpeedGraphEvent {}

class UpdateDataSourceEvent extends SpeedGraphEvent {
  final HomeScreenBloc model;

  UpdateDataSourceEvent({required this.model});

  @override
  List<Object> get props => [model];
}
