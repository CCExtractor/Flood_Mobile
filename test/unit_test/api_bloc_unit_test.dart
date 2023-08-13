import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc_event.dart';
import 'package:flood_mobile/Blocs/api_bloc/api_bloc_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter bindings

  group('ApiBloc', () {
    late ApiBloc apiBloc;

    setUp(() {
      apiBloc = ApiBloc();
    });

    tearDown(() {
      apiBloc.close();
    });

    blocTest<ApiBloc, ApiState>(
      'emits ApiState with updated URL after SetBaseUrlEvent',
      build: () => apiBloc,
      act: (bloc) => bloc.add(SetBaseUrlEvent(url: 'http://example.com')),
      expect: () => [
        ApiState(baseUrl: 'http://example.com'),
      ],
    );
  });
}
