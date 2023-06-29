import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flood_mobile/Pages/onboarding_main_screen/data/onboard_page_data.dart';
import 'package:flutter/material.dart';

part 'on_boarding_page_color_event.dart';
part 'on_boarding_page_color_state.dart';

class OnBoardingPageColorBloc
    extends Bloc<OnBoardingPageColorEvent, OnBoardingPageColorState> {
  Color color = onboardData[0].accentColor;
  OnBoardingPageColorBloc() : super(OnBoardingPageColorInitial()) {
    on<SetColorEvent>((event, emit) {
      // Update the color variable with the new color
      color = event.color;
      // Emit a ColorUpdated state with the new color
      emit(ColorUpdated(color: event.color));
    });
  }
}
