part of 'on_boarding_page_color_bloc.dart';

class OnBoardingPageColorState extends Equatable {
  final Color color;

  OnBoardingPageColorState({required this.color});

  factory OnBoardingPageColorState.initial() =>
      OnBoardingPageColorState(color: Color(0xff39C481));

  OnBoardingPageColorState copyWith({required Color? color}) =>
      OnBoardingPageColorState(color: color ?? this.color);

  @override
  List<Object> get props => [color];
}
