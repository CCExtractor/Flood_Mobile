part of 'sse_bloc.dart';

abstract class SSEState extends Equatable {
  @override
  List<Object> get props => [];
}

class SSEInitial extends SSEState {}

class SetSSEState extends SSEState {
  final SSEModel sseModel;

  SetSSEState({required this.sseModel});

  @override
  List<Object> get props => [sseModel];
}

class SSEListenState extends SSEState {
  final BuildContext context;

  SSEListenState({required this.context});

  @override
  List<Object> get props => [context];
}

class SSEUnsubscribeState extends SSEState {
  @override
  List<Object> get props => [];
}
