import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'on_boarding_page_color_event.dart';
part 'on_boarding_page_color_state.dart';

class OnBoardingPageColorBloc
    extends Bloc<OnBoardingPageColorEvent, OnBoardingPageColorState> {
  OnBoardingPageColorBloc() : super(OnBoardingPageColorState.initial()) {
    on<SetColorEvent>((event, emit) {
      // Emit a ColorUpdated state with the new color
      emit(state.copyWith(color: event.color));
    });
  }
}
