import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Blocs/onboarding_main_page_bloc/on_boarding_page_color_bloc.dart';

void main() {
  group('ColorBloc', () {
    late OnBoardingPageColorBloc colorBloc;

    setUp(() {
      colorBloc = OnBoardingPageColorBloc();
    });

    tearDown(() {
      colorBloc.close();
    });

    test('initial state should be OnBoardingPageColorState.initial()', () {
      expect(colorBloc.state, OnBoardingPageColorState.initial());
    });

    blocTest<OnBoardingPageColorBloc, OnBoardingPageColorState>(
      'Setting a new color should update the color state',
      build: () => colorBloc,
      act: (bloc) => bloc.add(SetColorEvent(color: Colors.blue)),
      expect: () => [
        OnBoardingPageColorState(color: Colors.blue),
      ],
    );
  });
}
