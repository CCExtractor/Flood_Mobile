import 'package:equatable/equatable.dart';

class ApiEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SetBaseUrlEvent extends ApiEvent {
  final String url;

  SetBaseUrlEvent({required this.url});

  @override
  List<Object> get props => [url];
}
