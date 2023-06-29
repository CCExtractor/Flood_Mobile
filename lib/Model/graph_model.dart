import 'package:equatable/equatable.dart';

class GraphModel extends Equatable {
  final double speed;
  final int second;
  GraphModel({required this.speed, required this.second});

  @override
  List<Object> get props => [speed, second];
}
