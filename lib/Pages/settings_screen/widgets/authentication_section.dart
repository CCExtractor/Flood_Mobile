import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flood_mobile/Api/auth_api.dart';
import 'package:flood_mobile/Blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:flood_mobile/Model/register_user_model.dart';
import 'package:flood_mobile/Pages/settings_screen/widgets/settings_text_field.dart';
import 'package:flood_mobile/Pages/settings_screen/widgets/user_list.dart';
import 'package:flood_mobile/Pages/widgets/flood_snackbar.dart';
import 'package:flood_mobile/Pages/widgets/text_size.dart';
import 'package:flood_mobile/Blocs/theme_bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationSection extends StatelessWidget {
  AuthenticationSection({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.isAdmin,
    required this.client,
    required this.socket,
    required this.pathController,
    required this.hostController,
    required this.portController,
    required this.clientUsernameController,
    required this.clientPasswordController,
    required this.urlController,
    required this.hp,
    required this.setClient,
    required this.setIsAdmin,
    required this.setSocket,
    required this.setTCP,
    required this.authenticationformKey,
    required this.themeIndex,
  }) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool isAdmin;
  final String client;
  final bool socket;
  final TextEditingController pathController;
  final TextEditingController hostController;
  final TextEditingController portController;
  final TextEditingController clientUsernameController;
  final TextEditingController clientPasswordController;
  final TextEditingController urlController;
  final double hp;
  final void Function(bool? value) setIsAdmin;
  final void Function(String? value) setClient;
  final void Function(bool? value) setSocket;
  final void Function(bool? value) setTCP;
  final GlobalKey<FormState> authenticationformKey;
  final int themeIndex;

  @override
  Widget build(BuildContext context) {
    // User is not Admin

    return BlocBuilder<UserDetailBloc, UserDetailState>(
      builder: (context, state) {
        if (state is UserDetailLoaded) {
          if (state.usersList.length == 0) {
            return ExpansionTileCard(
              key: Key('Authentication Expansion Card'),
              onExpansionChanged: (value) {},
              elevation: 0,
              expandedColor: ThemeBloc.theme(themeIndex).primaryColor,
              baseColor: ThemeBloc.theme(themeIndex).primaryColor,
              title: MText(text: 'Authentication'),
              leading: Icon(Icons.security),
              contentPadding: EdgeInsets.all(0),
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ThemeBloc.theme(themeIndex).colorScheme.error,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: ThemeBloc.theme(themeIndex).primaryColor,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("User is not Admin"),
                  ),
                ),
              ],
            );
          } else {
            return ExpansionTileCard(
              key: Key('Authentication Expansion Card'),
              onExpansionChanged: (value) {},
              elevation: 0,
              expandedColor: ThemeBloc.theme(themeIndex).primaryColor,
              baseColor: ThemeBloc.theme(themeIndex).primaryColor,
              expandedTextColor:
                  ThemeBloc.theme(themeIndex).colorScheme.secondary,
              title: MText(text: 'Authentication'),
              leading: Icon(Icons.security),
              contentPadding: EdgeInsets.all(0),
              children: [
                Form(
                  key: authenticationformKey,
                  child: Column(
                    key: Key('Authentication option display column'),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SText(text: 'User Accounts', themeIndex: themeIndex),
                      SizedBox(height: 25),
                      UsersListView(
                        usersList: state.usersList,
                        currentUsername: state.username,
                        themeIndex: themeIndex,
                      ),
                      SizedBox(height: 25),
                      SText(text: 'Add User', themeIndex: themeIndex),
                      SizedBox(height: 25),
                      SettingsTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username cannot be empty.";
                          }
                          return null;
                        },
                        hintText: 'Username',
                        labelText: 'Username',
                        controller: usernameController,
                        themeIndex: themeIndex,
                      ),
                      SizedBox(height: 20),
                      SettingsTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty.";
                          }
                          return null;
                        },
                        hintText: 'Password',
                        labelText: 'Password',
                        controller: passwordController,
                        themeIndex: themeIndex,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              key: Key('Is Admin checkbox'),
                              activeColor:
                                  ThemeBloc.theme(themeIndex).primaryColorDark,
                              tileColor:
                                  ThemeBloc.theme(themeIndex).primaryColorLight,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              title: Text(
                                'Is Admin',
                                style: TextStyle(fontSize: 12),
                              ),
                              value: isAdmin,
                              onChanged: setIsAdmin,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: ThemeBloc.theme(themeIndex)
                                    .primaryColorLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  key: Key('Authentication dropdown'),
                                  isExpanded: true,
                                  value: client,
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_rounded),
                                  dropdownColor: ThemeBloc.theme(themeIndex)
                                      .primaryColorLight,
                                  elevation: 16,
                                  onChanged: setClient,
                                  underline: Container(),
                                  items: <String>[
                                    'rTorrent',
                                    'qBittorrent',
                                    'Transmission',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      //Check if the client is rTorrent, qBittorrent or Transmission

                      (client == 'rTorrent')
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CheckboxListTile(
                                          key: Key('Socket checkbox'),
                                          tileColor: ThemeBloc.theme(themeIndex)
                                              .primaryColorLight,
                                          activeColor:
                                              ThemeBloc.theme(themeIndex)
                                                  .primaryColorDark,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          title: Text(
                                            'Socket',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          value: socket,
                                          onChanged: setSocket),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: CheckboxListTile(
                                        key: Key('TCP checkbox'),
                                        activeColor: ThemeBloc.theme(themeIndex)
                                            .primaryColorDark,
                                        tileColor: ThemeBloc.theme(themeIndex)
                                            .primaryColorLight,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        title: Text(
                                          'TCP',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        value: !socket,
                                        onChanged: setTCP,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                (socket)
                                    ? SettingsTextField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Path cannot be empty";
                                          }
                                          return null;
                                        },
                                        hintText: 'eg. ~/.local/share/rtorrent',
                                        labelText: 'Path',
                                        controller: pathController,
                                        themeIndex: themeIndex,
                                      )
                                    : Column(
                                        children: [
                                          SettingsTextField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Host or IP cannot be empty";
                                              }
                                              return null;
                                            },
                                            hintText: 'Host or IP',
                                            labelText: 'Host',
                                            controller: hostController,
                                            themeIndex: themeIndex,
                                          ),
                                          SizedBox(height: 20),
                                          SettingsTextField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Port cannot be empty";
                                              }
                                              return null;
                                            },
                                            hintText: 'Port',
                                            labelText: 'Port',
                                            controller: portController,
                                            themeIndex: themeIndex,
                                          )
                                        ],
                                      ),
                              ],
                            )
                          : Column(
                              children: [
                                SettingsTextField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Client Username cannot be empty.";
                                    }
                                    return null;
                                  },
                                  hintText: 'Client Username',
                                  labelText: 'Username',
                                  controller: clientUsernameController,
                                  themeIndex: themeIndex,
                                ),
                                SizedBox(height: 20),
                                SettingsTextField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Client Password cannot be empty.";
                                    }
                                    return null;
                                  },
                                  hintText: 'Client Password',
                                  labelText: 'Password',
                                  controller: clientPasswordController,
                                  themeIndex: themeIndex,
                                ),
                                SizedBox(height: 20),
                                SettingsTextField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "URL cannot be empty";
                                    } else if (!value.startsWith("http://")) {
                                      return "Enter valid URL";
                                    }
                                    return null;
                                  },
                                  hintText: client == "qBittorrent"
                                      ? 'eg. http://localhost:8080'
                                      : 'eg. http://localhost:9091/transmission/rpc',
                                  labelText: 'URL',
                                  controller: urlController,
                                  themeIndex: themeIndex,
                                ),
                              ],
                            ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Expanded(
                            child: Container(
                              height: hp * 0.06,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (authenticationformKey.currentState!
                                      .validate()) {
                                    AuthApi.registerUser(
                                      context: context,
                                      model: RegisterUserModel(
                                        username: usernameController.text,
                                        password: passwordController.text,
                                        client: client,
                                        type: (client == 'rTorrent')
                                            ? (socket)
                                                ? 'socket'
                                                : 'tcp'
                                            : "web",
                                        version: 1,
                                        url: urlController.text,
                                        clientUsername:
                                            clientUsernameController.text,
                                        clientPassword:
                                            clientPasswordController.text,
                                        level: isAdmin ? 10 : 5,
                                        path: pathController.text,
                                        host: hostController.text,
                                        port: int.parse(
                                          portController.text.isEmpty
                                              ? "0"
                                              : portController.text,
                                        ),
                                      ),
                                    );
                                    AuthApi.getUsersList(context);
                                    usernameController.clear();
                                    passwordController.clear();
                                    pathController.clear();
                                    clientUsernameController.clear();
                                    clientPasswordController.clear();
                                    urlController.clear();
                                    hostController.clear();
                                    portController.clear();
                                    setIsAdmin(false);
                                    setSocket(true);
                                    setClient('rTorrent');

                                    final addNewUserSnackBar = addFloodSnackBar(
                                        SnackbarType.success,
                                        'New user added',
                                        'Dismiss');

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(addNewUserSnackBar);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: ThemeBloc.theme(themeIndex)
                                      .colorScheme
                                      .secondary,
                                ),
                                child: Center(
                                  child: Text(
                                    "Add",
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
                    ],
                  ),
                )
              ],
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
