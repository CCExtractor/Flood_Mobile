import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Blocs/language_bloc/language_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Constants/languages.dart';
import 'package:flood_mobile/Pages/widgets/flood_snackbar.dart';
import 'package:flood_mobile/Pages/widgets/text_size.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInterfaceSection extends StatelessWidget {
  final int themeIndex;
  final double hp;
  UserInterfaceSection({
    Key? key,
    required this.themeIndex,
    required this.hp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
      String selectedLanguageCode = state.locale?.languageCode ?? 'auto';
      String selectedLanguage = Languages[selectedLanguageCode] ?? 'Automatic';
      return ExpansionTileCard(
        key: Key('User Interface Expansion Card'),
        onExpansionChanged: (value) {},
        elevation: 0,
        expandedColor: ThemeBloc.theme(themeIndex).primaryColor,
        baseColor: ThemeBloc.theme(themeIndex).primaryColor,
        expandedTextColor: ThemeBloc.theme(themeIndex).colorScheme.secondary,
        title: MText(text: l10n.settings_tabs_user_interface),
        leading: Icon(Icons.mobile_friendly),
        contentPadding: EdgeInsets.all(0),
        children: [
          Column(
            key: Key('User Interface options display column'),
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
              ),
              SText(
                  text: l10n.settings_language_section_heading,
                  themeIndex: themeIndex),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: ThemeBloc.theme(themeIndex).primaryColorLight,
                        border: null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: DropdownButtonFormField<String>(
                          key: Key('Select Language Dropdown'),
                          dropdownColor:
                              ThemeBloc.theme(themeIndex).primaryColorLight,
                          isExpanded: true,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: ThemeBloc.theme(themeIndex)
                                .textTheme
                                .bodyLarge
                                ?.color,
                            size: 25,
                          ),
                          items: Languages.values
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (newselectedLanguage) {
                            Languages.forEach((key, value) {
                              if (value == newselectedLanguage) {
                                selectedLanguageCode = key;
                                selectedLanguage = value;
                              }
                            });
                          },
                          value: selectedLanguage,
                        ),
                      )),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(
                    child: Container(
                      height: hp * 0.06,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (selectedLanguage == 'Automatic') {
                            BlocProvider.of<LanguageBloc>(context,
                                    listen: false)
                                .add(ChangeLanguageEvent(null));
                          } else {
                            BlocProvider.of<LanguageBloc>(context,
                                    listen: false)
                                .add(ChangeLanguageEvent(
                                    Locale(selectedLanguageCode)));
                          }
                          await Future.delayed(Duration.zero);
                          final setSpeedSnackbar = addFloodSnackBar(
                            SnackbarType.information,
                            l10n.settings_language_set_snackbar,
                            l10n.button_dismiss,
                          );
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(setSpeedSnackbar);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor:
                              ThemeBloc.theme(themeIndex).colorScheme.secondary,
                        ),
                        child: Center(
                          child: Text(
                            l10n.button_set,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
            ],
          )
        ],
      );
    });
  }
}
