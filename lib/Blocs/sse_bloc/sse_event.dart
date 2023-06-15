part of 'sse_bloc.dart';

abstract class SSEEvent extends Equatable {
  const SSEEvent();
  @override
  List<Object> get props => [];
}

class SetSSEEvent extends SSEEvent {
  final SSEModel sseModel;

  SetSSEEvent({required this.sseModel});

  @override
  List<Object> get props => [sseModel];
}

class SetSSEListenEvent extends SSEEvent {
  final BuildContext context;

  SetSSEListenEvent({required this.context});

  @override
  List<Object> get props => [context];
}

class SetSSEUnsubscribeEvent extends SSEEvent {}
