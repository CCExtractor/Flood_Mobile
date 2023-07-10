part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final Locale? locale;

  LanguageState(this.locale);

  factory LanguageState.initial() => LanguageState(null);

  LanguageState copyWith(Locale? locale) => LanguageState(locale);

  @override
  List<Object?> get props => [locale];
}
