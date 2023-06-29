import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    print('Bloc created: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    print('Bloc event: ${bloc.runtimeType}, Event: $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    print('Bloc state change: ${bloc.runtimeType}, Change: $change');
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    print('Bloc transition: ${bloc.runtimeType}, Transition: $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('Bloc error: ${bloc.runtimeType}, Error: $error');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    print('Bloc closed: ${bloc.runtimeType}');
  }
}
