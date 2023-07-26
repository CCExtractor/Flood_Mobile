part of 'user_interface_bloc.dart';

abstract class UserInterfaceEvent extends Equatable {
  const UserInterfaceEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserInterfaceEvent extends UserInterfaceEvent {
  final UserInterfaceModel model;

  const UpdateUserInterfaceEvent({required this.model});

  @override
  List<Object> get props => [model];
}

class GetPreviousSetUserInterfaceEvent extends UserInterfaceEvent {}
