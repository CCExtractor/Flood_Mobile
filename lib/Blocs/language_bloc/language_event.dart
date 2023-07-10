part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object?> get props => [];
}

class ChangeLanguageEvent extends LanguageEvent {
  final Locale? languageCode;

  const ChangeLanguageEvent(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}

class GetPreviousLanguageEvent extends LanguageEvent {}
