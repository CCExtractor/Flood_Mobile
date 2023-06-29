part of 'on_boarding_page_color_bloc.dart';

abstract class OnBoardingPageColorState extends Equatable {
  const OnBoardingPageColorState();

  @override
  List<Object> get props => [];
}

class OnBoardingPageColorInitial extends OnBoardingPageColorState {}

class ColorUpdated extends OnBoardingPageColorState {
  final Color color;

  ColorUpdated({required this.color});

  @override
  List<Object> get props => [color];
}
