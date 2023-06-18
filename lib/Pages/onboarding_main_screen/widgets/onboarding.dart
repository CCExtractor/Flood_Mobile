import 'package:flood_mobile/Blocs/onboarding_main_page_bloc/on_boarding_page_color_bloc.dart';
import 'package:flood_mobile/Model/onboard_page_model.dart';
import 'package:flood_mobile/Pages/onboarding_main_screen/data/onboard_page_data.dart';
import 'package:flood_mobile/Pages/onboarding_main_screen/widgets/onboard_page.dart';
import 'package:flood_mobile/Route/routes.dart';
import 'package:flood_mobile/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController pageController = PageController();
  late OnboardPageModel pageModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingPageColorBloc, OnBoardingPageColorState>(
      builder: (context, state) {
        return GestureDetector(
          onPanUpdate: (details) {
            // Swiping in right direction.
            if (details.delta.dx > 0) {
              pageModel =
                  onboardData(context)[pageController.page?.round() ?? 0];
              _previousPage();
            }

            // Swiping in left direction.
            if (details.delta.dx < 0) {
              pageModel =
                  onboardData(context)[pageController.page?.round() ?? 0];
              if (pageController.page?.round() == 2) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.loginScreenRoute, (Route<dynamic> route) => false);
              } else {
                _nextPage();
              }
            }
          },
          child: Stack(
            children: <Widget>[
              PageView.builder(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                itemCount: onboardData(context).length,
                itemBuilder: (context, index) {
                  return OnboardPage(
                    pageController: pageController,
                    pageModel: onboardData(context)[index],
                    key: Key(''),
                  );
                },
              ),
              Container(
                width: double.infinity,
                height: 100,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20.0, bottom: 10.0),
                        child: Text(
                          context.l10n.explore_flood_mobile,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: state.color,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 32.0, bottom: 10.0),
                        child: ElevatedButton(
                          key: Key('skipButton'),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.loginScreenRoute,
                                (Route<dynamic> route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            backgroundColor: Color(0xff305067),
                          ),
                          child: Text(
                            context.l10n.button_skip,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60.0, left: 40),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: WormEffect(
                      dotColor: state.color,
                      activeDotColor: state.color,
                      dotHeight: 16,
                      dotWidth: 16,
                      type: WormType.normal,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _nextPage() {
    BlocProvider.of<OnBoardingPageColorBloc>(context, listen: false)
        .add(SetColorEvent(color: pageModel.nextAccentColor));
    pageController.nextPage(
      duration: Duration(
        milliseconds: 1500,
      ),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  _previousPage() {
    BlocProvider.of<OnBoardingPageColorBloc>(context, listen: false)
        .add(SetColorEvent(color: pageModel.nextAccentColor));
    pageController.previousPage(
      duration: Duration(
        milliseconds: 1500,
      ),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }
}
