import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Blocs/language_bloc/language_bloc.dart';

void main() {
  group('LanguageBloc', () {
    late LanguageBloc languageBloc;

    setUp(() {
      languageBloc = LanguageBloc();
    });

    tearDown(() {
      languageBloc.close();
    });

    test('initial state should be LanguageState.initial()', () {
      expect(languageBloc.state, LanguageState.initial());
    });

    blocTest<LanguageBloc, LanguageState>(
      'emits LanguageState with the updated locale when ChangeLanguageEvent is added',
      build: () => languageBloc,
      act: (bloc) => bloc.add(ChangeLanguageEvent(Locale('en'))),
      expect: () => [LanguageState(Locale('en'))],
    );
  });
}
