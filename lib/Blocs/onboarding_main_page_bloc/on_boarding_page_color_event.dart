part of 'on_boarding_page_color_bloc.dart';

abstract class OnBoardingPageColorEvent extends Equatable {
  const OnBoardingPageColorEvent();

  @override
  List<Object> get props => [];
}

class SetColorEvent extends OnBoardingPageColorEvent {
  final Color color;

  SetColorEvent({required this.color});

  @override
  List<Object> get props => [color];
}
