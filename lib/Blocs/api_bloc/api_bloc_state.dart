import 'package:equatable/equatable.dart';

class ApiState extends Equatable {
  final String baseUrl;

  ApiState({required this.baseUrl});

  @override
  List<Object> get props => [baseUrl];
}
