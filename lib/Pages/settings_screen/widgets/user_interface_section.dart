import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flood_mobile/Blocs/language_bloc/language_bloc.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Blocs/user_interface_bloc/user_interface_bloc.dart';
import 'package:flood_mobile/Constants/languages.dart';
import 'package:flood_mobile/Model/user_interface_model.dart';
import 'package:flood_mobile/Pages/widgets/flood_snackbar.dart';
import 'package:flood_mobile/Pages/widgets/text_size.dart';
import 'package:flood_mobile/l10n/l10n.dart';

// ignore: must_be_immutable
class UserInterfaceSection extends StatefulWidget {
  final int themeIndex;
  final double hp;
  Map<String, bool> torrentScreenItems;
  Map<String, bool> contextMenuItems;
  final TagPreferenceButtonValue selectedRadioButton;
  final void Function(TagPreferenceButtonValue? value) tagSelectionOnChange;

  UserInterfaceSection({
    Key? key,
    required this.themeIndex,
    required this.hp,
    required this.torrentScreenItems,
    required this.contextMenuItems,
    required this.selectedRadioButton,
    required this.tagSelectionOnChange,
  }) : super(key: key);

  @override
  State<UserInterfaceSection> createState() => _UserInterfaceSectionState();
}

class _UserInterfaceSectionState extends State<UserInterfaceSection> {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
      String selectedLanguageCode = state.locale?.languageCode ?? 'auto';
      String selectedLanguage = Languages[selectedLanguageCode] ?? 'Automatic';
      return BlocBuilder<UserInterfaceBloc, UserInterfaceState>(
        builder: (context, userInterfaceState) {
          return ExpansionTileCard(
            key: Key('User Interface Expansion Card'),
            onExpansionChanged: (value) {},
            elevation: 0,
            expandedColor: ThemeBloc.theme(widget.themeIndex).primaryColor,
            baseColor: ThemeBloc.theme(widget.themeIndex).primaryColor,
            expandedTextColor:
                ThemeBloc.theme(widget.themeIndex).colorScheme.secondary,
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
                      themeIndex: widget.themeIndex),
                  SizedBox(height: widget.hp * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          height: widget.hp * 0.072,
                          decoration: BoxDecoration(
                            color: ThemeBloc.theme(widget.themeIndex)
                                .primaryColorLight,
                            border: null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: DropdownButtonFormField<String>(
                              key: Key('Select Language Dropdown'),
                              dropdownColor: ThemeBloc.theme(widget.themeIndex)
                                  .primaryColorLight,
                              isExpanded: true,
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                              ),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: ThemeBloc.theme(widget.themeIndex)
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
                  SizedBox(height: widget.hp * 0.02),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                        child: Container(
                          height: widget.hp * 0.06,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
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
                                context.l10n.settings_language_set_snackbar,
                                context.l10n.button_dismiss,
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
                                  ThemeBloc.theme(widget.themeIndex)
                                      .colorScheme
                                      .secondary,
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
                  SizedBox(height: widget.hp * 0.03),
                  SText(
                    text: l10n.torrent_screen_items_heading,
                    themeIndex: widget.themeIndex,
                  ),
                  SizedBox(height: widget.hp * 0.02),
                  Container(
                      height: widget.hp * 0.4,
                      decoration: BoxDecoration(
                        color: ThemeBloc.theme(widget.themeIndex)
                            .primaryColorLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return CheckboxListTile(
                            key: Key(widget.torrentScreenItems.keys
                                .elementAt(index)
                                .toString()),
                            activeColor: ThemeBloc.theme(widget.themeIndex)
                                .primaryColorDark,
                            value: widget.torrentScreenItems.values
                                .elementAt(index),
                            onChanged: (value) {
                              setState(() {
                                widget.torrentScreenItems.update(
                                    widget.torrentScreenItems.keys
                                        .elementAt(index),
                                    (value) => !value);
                              });
                            },
                            title: Text(widget.torrentScreenItems.keys
                                .elementAt(index)),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Divider(
                              color: Colors.grey[400],
                              height: 2,
                            ),
                          );
                        },
                        itemCount: widget.torrentScreenItems.length,
                      )),
                  SizedBox(height: widget.hp * 0.02),
                  SText(
                    text: l10n.context_menu_items_heading,
                    themeIndex: widget.themeIndex,
                  ),
                  SizedBox(height: widget.hp * 0.02),
                  Container(
                    height: widget.hp * 0.4,
                    decoration: BoxDecoration(
                      color:
                          ThemeBloc.theme(widget.themeIndex).primaryColorLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          key: Key(widget.contextMenuItems.keys
                              .elementAt(index)
                              .toString()),
                          activeColor: ThemeBloc.theme(widget.themeIndex)
                              .primaryColorDark,
                          value:
                              widget.contextMenuItems.values.elementAt(index),
                          onChanged: (value) {
                            setState(() {
                              widget.contextMenuItems.update(
                                  widget.contextMenuItems.keys.elementAt(index),
                                  (value) => !value);
                            });
                          },
                          title: Text(
                              widget.contextMenuItems.keys.elementAt(index)),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Divider(
                            color: Colors.grey[400],
                            height: 2,
                          ),
                        );
                      },
                      itemCount: widget.contextMenuItems.length,
                    ),
                  ),
                  SizedBox(height: widget.hp * 0.02),
                  SText(
                    text: l10n.tag_selection_heading,
                    themeIndex: widget.themeIndex,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.single_selection_radio_button),
                          value: TagPreferenceButtonValue.singleSelection,
                          groupValue: widget.selectedRadioButton,
                          onChanged: widget.tagSelectionOnChange,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.multi_selection_radio_button),
                          value: TagPreferenceButtonValue.multiSelection,
                          groupValue: widget.selectedRadioButton,
                          onChanged: widget.tagSelectionOnChange,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          );
        },
      );
    });
  }
}
