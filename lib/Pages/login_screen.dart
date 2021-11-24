import 'package:clipboard/clipboard.dart';
import 'package:flood_mobile/Api/auth_api.dart';
import 'package:flood_mobile/Components/toast_component.dart';
import 'package:flood_mobile/Constants/app_color.dart';
import 'package:flood_mobile/Constants/theme_provider.dart';
import 'package:flood_mobile/Provider/api_provider.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPass = true;
  bool showSpinner = false;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController urlController =
      new TextEditingController(text: 'http://localhost:3000');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double hp = MediaQuery.of(context).size.height;
    double wp = MediaQuery.of(context).size.width;
    return LoadingOverlay(
      color: ThemeProvider.theme.primaryColor,
      isLoading: showSpinner,
      child: Scaffold(
        backgroundColor: ThemeProvider.theme.primaryColor,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: wp * 0.08, right: wp * 0.08, top: hp * 0.08),
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage(
                          'assets/images/icon.png',
                        ),
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        'Welcome to Flood',
                        style: TextStyle(
                            color:
                                ThemeProvider.theme.textTheme.bodyText1!.color!,
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                      Text(
                        'Sign in to your account',
                        style: TextStyle(
                            color:
                                ThemeProvider.theme.textTheme.bodyText1!.color!,
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: hp * 0.06,
                      ),
                      Container(
                        child: Stack(
                          children: [
                            TextFormField(
                              controller: urlController,
                              style: TextStyle(
                                color: ThemeProvider
                                    .theme.textTheme.bodyText1?.color,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.link,
                                  color: ThemeProvider
                                      .theme.textTheme.bodyText1!.color!,
                                ),
                                labelText: 'URL',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1!.color!),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ThemeProvider.theme.primaryColorDark,
                                  ),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1!.color!,
                                  ),
                                ),
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1!.color!,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1!.color!,
                                  ),
                                ),
                              ),
                              validator: (String? value) {
                                if (value != null && value.isEmpty) {
                                  return 'Field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  FlutterClipboard.paste().then((value) {
                                    setState(() {
                                      urlController.text = value;
                                    });
                                  });
                                },
                                icon: Icon(
                                  Icons.paste,
                                  color: ThemeProvider
                                      .theme.textTheme.bodyText1!.color!,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: hp * 0.01,
                      ),
                      Container(
                        child: TextFormField(
                          controller: usernameController,
                          style: TextStyle(
                            color:
                                ThemeProvider.theme.textTheme.bodyText1!.color!,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: ThemeProvider
                                  .theme.textTheme.bodyText1!.color!,
                            ),
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: ThemeProvider
                                    .theme.textTheme.bodyText1!.color!),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeProvider.theme.primaryColorDark,
                              ),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeProvider
                                    .theme.textTheme.bodyText1!.color!,
                              ),
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeProvider
                                    .theme.textTheme.bodyText1!.color!,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ThemeProvider
                                    .theme.textTheme.bodyText1!.color!,
                              ),
                            ),
                          ),
                          validator: (String? value) {
                            if (value != null && value.isEmpty) {
                              return 'Field cannot be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: hp * 0.01,
                      ),
                      Container(
                        child: Stack(
                          children: <Widget>[
                            TextFormField(
                              controller: passwordController,
                              style: TextStyle(
                                color: ThemeProvider
                                    .theme.textTheme.bodyText1?.color,
                              ),
                              obscureText: showPass,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: ThemeProvider
                                      .theme.textTheme.bodyText1!.color!,
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1!.color!),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ThemeProvider.theme.primaryColorDark,
                                  ),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1!.color!,
                                  ),
                                ),
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1!.color!,
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ThemeProvider
                                        .theme.textTheme.bodyText1!.color!,
                                  ),
                                ),
                              ),
                              validator: (String? value) {
                                if (value != null && value.isEmpty) {
                                  return 'Field cannot be empty';
                                }
                                return null;
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPass = !showPass;
                                  });
                                  print(showPass);
                                },
                                icon: Icon(
                                  (showPass)
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ThemeProvider
                                      .theme.textTheme.bodyText1!.color!,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: hp * 0.06,
                      ),
                      Container(
                        height: hp * 0.07,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              Provider.of<ApiProvider>(context, listen: false)
                                  .setBaseUrl(urlController.text);
                              setState(() {
                                showSpinner = true;
                              });
                              bool isLoginSuccessful = await AuthApi.loginUser(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                  context: context);
                              if (isLoginSuccessful) {
                                Toasts.showSuccessToast(
                                    msg: 'Login Successful');
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.homeScreenRoute,
                                    (Route<dynamic> route) => false);
                              } else {
                                Toasts.showFailToast(msg: 'Login Error');
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            primary: ThemeProvider.theme.primaryColorDark,
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: ThemeProvider
                                      .theme.textTheme.bodyText1!.color!,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: hp * 0.06,
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.github,
                        ),
                        onPressed: () {
                          launch(
                            'https://github.com/CCExtractor/Flood_Mobile#usage--screenshots',
                          );
                        },
                        iconSize: hp * 0.05,
                      ),
                      SizedBox(
                        height: hp * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
