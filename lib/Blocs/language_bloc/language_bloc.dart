import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState.initial()) {
    on<ChangeLanguageEvent>(_handleChangeLanguageEvent);
    on<GetPreviousLanguageEvent>(_handleGetPreviousSetLanguage);
  }

  Future<void> _handleChangeLanguageEvent(
      ChangeLanguageEvent event, Emitter<LanguageState> emit) async {
    await storeCurrentLang(event.languageCode);
    emit(state.copyWith(event.languageCode));
  }

  void _handleGetPreviousSetLanguage(
      GetPreviousLanguageEvent event, Emitter<LanguageState> emit) async {
    Locale? storedLanguageCode = await getPreviousLang();
    emit(state.copyWith(storedLanguageCode));
  }

  Future<Locale?> getPreviousLang() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString('languageCode') != 'null')
        return Locale(prefs.getString('languageCode')!);
      else {
        return null;
      }
    } catch (error) {
      print('Error retrieving language code from SharedPreferences: $error');
    }
    return null;
  }

  Future<void> storeCurrentLang(Locale? code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (code == null)
        await prefs.setString('languageCode', 'null');
      else
        await prefs.setString('languageCode', code.languageCode);
    } catch (error) {
      print('Error retrieving language code from SharedPreferences: $error');
    }
  }
}
