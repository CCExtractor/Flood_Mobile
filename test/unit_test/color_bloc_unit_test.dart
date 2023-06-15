import 'package:bloc_test/bloc_test.dart';
import 'package:flood_mobile/Blocs/onboarding_main_page_bloc/on_boarding_page_color_bloc.dart';
import 'package:flood_mobile/Pages/onboarding_main_screen/data/onboard_page_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorBloc', () {
    late OnBoardingPageColorBloc colorBloc;

    setUp(() {
      colorBloc = OnBoardingPageColorBloc();
    });

    test(
        'Initial color should match the first accent color from the onboard data',
        () {
      expect(colorBloc.color, equals(onboardData[0].accentColor));
    });

    blocTest<OnBoardingPageColorBloc, OnBoardingPageColorState>(
      'Setting a new color should update the color state',
      build: () => colorBloc,
      act: (bloc) => bloc..add(SetColorEvent(color: Colors.blue)),
      expect: () => [
        ColorUpdated(color: Colors.blue),
      ],
    );
  });
}
