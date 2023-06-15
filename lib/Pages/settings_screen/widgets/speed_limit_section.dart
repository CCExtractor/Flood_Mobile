import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Api/client_api.dart';
import 'package:flood_mobile/Blocs/client_settings_bloc/client_settings_bloc.dart';
import 'package:flood_mobile/Pages/widgets/flood_snackbar.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/Pages/widgets/text_size.dart';
import 'package:flood_mobile/Services/transfer_speed_manager.dart';
import 'package:flutter/material.dart';

class SpeedLimitSection extends StatelessWidget {
  SpeedLimitSection(
      {Key? key,
      required this.hp,
      required this.downSpeed,
      required this.setDownSpeed,
      required this.setUpSpeed,
      required this.upSpeed,
      required this.bloc,
      required this.themeIndex})
      : super(key: key);

  final double hp;
  final String upSpeed;
  final String downSpeed;
  final void Function(String? value) setUpSpeed;
  final void Function(String? value) setDownSpeed;
  final ClientSettingsBloc bloc;
  final int themeIndex;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      key: Key('Speed Limit Expansion Card'),
      onExpansionChanged: (value) {},
      elevation: 0,
      expandedColor: ThemeBloc.theme(themeIndex).primaryColor,
      baseColor: ThemeBloc.theme(themeIndex).primaryColor,
      expandedTextColor: ThemeBloc.theme(themeIndex).colorScheme.secondary,
      title: MText(text: 'Speed Limit'),
      leading: Icon(Icons.speed_rounded),
      contentPadding: EdgeInsets.all(0),
      children: [
        Column(
          key: Key('Speed Limit options column'),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
            ),
            SText(text: 'Download', themeIndex: themeIndex),
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
                        key: Key('Download Speed Dropdown'),
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
                        hint: Text("Download Speed"),
                        items: TransferSpeedManager.speedToValMap.keys
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                  ),
                                ))
                            .toList(),
                        onChanged: setDownSpeed,
                        value: TransferSpeedManager.valToSpeedMap[
                                bloc.clientSettings.throttleGlobalDownSpeed] ??
                            'Unlimited',
                      ),
                    )),
              ],
            ),
            SizedBox(height: 25),
            SText(text: 'Upload', themeIndex: themeIndex),
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
                        key: Key('Upload Speed Dropdown'),
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
                        hint: Text("Upload Speed"),
                        items: TransferSpeedManager.speedToValMap.keys
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                  ),
                                ))
                            .toList(),
                        onChanged: setUpSpeed,
                        value: TransferSpeedManager.valToSpeedMap[
                                bloc.clientSettings.throttleGlobalUpSpeed] ??
                            'Unlimited',
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
                      onPressed: () {
                        ClientApi.setSpeedLimit(
                            context: context,
                            downSpeed: downSpeed,
                            upSpeed: upSpeed);
                        final setSpeedSnackbar = addFloodSnackBar(
                            SnackbarType.information,
                            'Speed set successfully',
                            'Dismiss');
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
                          "Set",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
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
  }
}
