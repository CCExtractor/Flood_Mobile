import 'package:flutter/material.dart';
import 'package:optimize_battery/optimize_battery.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flood_mobile/l10n/l10n.dart';

class CustomDialogAnimation extends StatelessWidget {
  final int themeIndex;

  const CustomDialogAnimation({Key? key, required this.themeIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          // Bottom rectangular box
          margin:
              EdgeInsets.only(top: 40), // to push the box half way below circle
          decoration: BoxDecoration(
            color: ThemeBloc.theme(themeIndex).primaryColorLight,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.only(
            top: 0,
          ), // spacing inside the box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkWell(
                child: Align(
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.cancel,
                      color: ThemeBloc.theme(themeIndex).primaryColorDark,
                      size: 30,
                    ),
                  ),
                  alignment: Alignment.topRight,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 20),
                child: Column(
                  children: [
                    new Text(l10n.battery_optimization_dialog_title,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: ThemeBloc.theme(themeIndex)
                                .textTheme
                                .bodyLarge
                                ?.color,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(l10n.battery_optimization_dialog_desc1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.0,
                            color: ThemeBloc.theme(themeIndex)
                                .textTheme
                                .bodyLarge
                                ?.color)),
                    SizedBox(height: 10),
                    Text(l10n.battery_optimization_dialog_desc2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45))
                  ],
                ),
              ) //
                  ),
              SizedBox(height: 24.0),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, bottom: 10),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${l10n.remove_battery_text} \n${l10n.optimisation_text}",
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          l10n.remove_battery_optimization_text,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          l10n.or_text,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          l10n.remove_battery_optimization_steps,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 80),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black26,
                                  size: 25,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              OptimizeBattery.openBatteryOptimizationSettings();
                            },
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(width: 0.2, color: Colors.black),
                              backgroundColor:
                                  ThemeBloc.theme(themeIndex).primaryColorDark,
                              elevation: 0.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            child: Container(
                              height: 45,
                              child: Center(
                                child: Text(
                                  l10n.update_batter_settings_button,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w800),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  OptimizeBattery.openBatteryOptimizationSettings();
                },
              )
            ],
          ),
        ),
        CircleAvatar(
          radius: 40.0,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.settings,
            color: ThemeBloc.theme(themeIndex).primaryColorDark,
            size: 50,
          ),
        ),
      ],
    );
  }
}
